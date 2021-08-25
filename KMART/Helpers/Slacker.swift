//
//  Slacker.swift
//  KMART
//
//  Created by Nindi Gill on 20/8/21.
//

import Foundation

struct Slacker {

    private static let chatPostMessageURL: String = "https://slack.com/api/chat.postMessage"
    private static let filesUploadURL: String = "https://slack.com/api/files.upload"

    static func send(_ reports: Reports, using configuration: Configuration) {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        let slack: Slack = configuration.slack

        PrettyPrint.print("Sending Report(s) via Slack")

        guard let timestamp: String = message(slack, using: semaphore) else {
            return
        }

        for attachment in slack.attachments {
            if let data: Data = reports.data(type: attachment, using: configuration) {
                upload(data, of: attachment, for: slack, timestamp: timestamp, using: semaphore)
            }
        }
    }

    private static func urlRequest(_ url: URL, token: String, contentType: String, httpBody: Data?) -> URLRequest {
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        return request
    }

    private static func message(_ slack: Slack, using semaphore: DispatchSemaphore) -> String? {

        guard let url: URL = URL(string: chatPostMessageURL) else {
            PrettyPrint.print("Invalid URL: \(chatPostMessageURL)")
            return nil
        }

        var timestamp: String?
        let request: URLRequest = urlRequest(url, token: slack.token, contentType: "application/json; charset=UTF-8", httpBody: messageData(for: slack))

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error: Error = error {
                PrettyPrint.print(error.localizedDescription)
                semaphore.signal()
                return
            }

            guard let response: URLResponse = response,
                let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                PrettyPrint.print("Unable to get response from URL: \(url)")
                semaphore.signal()
                return
            }

            guard httpResponse.statusCode == 200 else {
                let string: String = HTTP.errorMessage(httpResponse.statusCode, url: url)
                PrettyPrint.print(string)
                semaphore.signal()
                return
            }

            guard let data: Data = data,
                let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                PrettyPrint.print("Invalid response data from URL: \(url)")
                semaphore.signal()
                return
            }

            if let string: String = dictionary["error"] as? String {
                PrettyPrint.print("Error response: \(string)")
                semaphore.signal()
                return
            }

            if let string: String = dictionary["warning"] as? String {
                PrettyPrint.print("Warning response: \(string)")
            }

            guard let string: String = dictionary["ts"] as? String else {
                PrettyPrint.print("Missing 'ts' key in response dictionary")
                semaphore.signal()
                return
            }

            timestamp = string
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return timestamp
    }

    private static func messageData(for slack: Slack) -> Data? {

        let dictionary: [String: Any] = [
            "channel": slack.channel,
            "blocks": [
                [
                    "type": "section",
                    "text": [
                        "type": "mrkdwn",
                        "text": slack.text
                    ]
                ]
            ],
            "text": Slack.defaultText
        ]

        guard let data: Data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            PrettyPrint.print("Invalid dictionary: \(dictionary)")
            return nil
        }

        return data
    }

    private static func upload(_ data: Data, of outputType: OutputType, for slack: Slack, timestamp: String, using semaphore: DispatchSemaphore) {

        guard let url: URL = URL(string: filesUploadURL) else {
            PrettyPrint.print("Invalid URL: \(filesUploadURL)")
            return
        }

        let boundary: String = "\(String.identifier).\(UUID().uuidString)"
        let request: URLRequest = urlRequest(
            url,
            token: slack.token,
            contentType: "multipart/form-data; boundary=\(boundary)",
            httpBody: uploadData(from: data, of: outputType, for: slack, timestamp: timestamp, boundary: boundary)
        )

        PrettyPrint.print("Uploading \(outputType.description) report via Slack")

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error: Error = error {
                PrettyPrint.print(error.localizedDescription)
                semaphore.signal()
                return
            }

            guard let response: URLResponse = response,
                let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                PrettyPrint.print("Unable to get response from URL: \(url)")
                semaphore.signal()
                return
            }

            guard httpResponse.statusCode == 200 else {
                let string: String = HTTP.errorMessage(httpResponse.statusCode, url: url)
                PrettyPrint.print(string)
                semaphore.signal()
                return
            }

            guard let data: Data = data,
                let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                PrettyPrint.print("Invalid response data from URL: \(url)")
                semaphore.signal()
                return
            }

            if let string: String = dictionary["error"] as? String {
                PrettyPrint.print("Error response: \(string)")
                semaphore.signal()
                return
            }

            if let string: String = dictionary["warning"] as? String {
                PrettyPrint.print("Warning response: \(string)")
            }

            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }

    private static func uploadData(from data: Data, of outputType: OutputType, for slack: Slack, timestamp: String, boundary: String) -> Data? {

        guard let file: String = String(data: data, encoding: .utf8) else {
            PrettyPrint.print("Invalid report file data")
            return nil
        }

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: Date())
        let filename: String = "KMART Report \(dateString).\(outputType.fileExtension)"
        let parameters: [(key: String, value: String, filename: String?)] = [
            (key: "channels", value: slack.channel, nil),
            (key: "file", value: file, filename: filename),
            (key: "filetype", value: outputType.filetype, nil),
            (key: "thread_ts", value: timestamp, nil),
            (key: "title", value: filename, nil)
        ]

        var string: String = ""

        for parameter in parameters {
            string.append("--\(boundary)\n")

            if let filename: String = parameter.filename {
                string.append("Content-Disposition: form-data; name=\"\(parameter.key)\"; filename=\"\(filename)\"\n\n")
            } else {
                string.append("Content-Disposition: form-data; name=\"\(parameter.key)\"\n\n")
            }

            string.append("\(parameter.value)\n")
        }

        return string.data(using: .utf8)
    }
}
