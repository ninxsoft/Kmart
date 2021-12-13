//
//  Slacker.swift
//  KMART
//
//  Created by Nindi Gill on 20/8/21.
//

import Foundation

/// Struct used to perform all **Slack** operations.
struct Slacker {

    /// Slack chat.postMessage API endpoint URL
    private static let chatPostMessageURL: String = "https://slack.com/api/chat.postMessage"
    /// Slack files.upload API endpoint URL
    private static let filesUploadURL: String = "https://slack.com/api/files.upload"

    /// Send a Slack message with an attached report.
    ///
    /// - Parameters:
    ///   - reports:       The reports to send via Slack.
    ///   - configuration: The configuration containing Slack settings.
    static func send(_ reports: Reports, using configuration: Configuration) {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        let slack: SlackConfiguration = configuration.slack

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

    /// Generate a HTTP POST `URLRequest` from the provided parameters.
    ///
    /// - Parameters:
    ///   - url:         The Slack API endpoint URL.
    ///   - token:       The Slack API user bearer token.
    ///   - contentType: The value for the HTTP Content-Type header (eg. `application/json; charset=UTF-8`).
    ///   - httpBody:    Optional HTTP POST body
    /// - Returns: A `URLRequest` object.
    private static func urlRequest(_ url: URL, token: String, contentType: String, httpBody: Data?) -> URLRequest {
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        return request
    }

    /// Send a Slack message.
    ///
    /// - Parameters:
    ///   - slack:     The Slack configuration.
    ///   - semaphore: The common semaphore used to wait for operations to complete.
    /// - Returns: A timestamp `String` if successful, otherwise `nil`.
    private static func message(_ slack: SlackConfiguration, using semaphore: DispatchSemaphore) -> String? {

        guard let url: URL = URL(string: chatPostMessageURL) else {
            PrettyPrint.print("Invalid URL: \(chatPostMessageURL)")
            return nil
        }

        var timestamp: String?
        let request: URLRequest = urlRequest(url, token: slack.token, contentType: "application/json; charset=UTF-8", httpBody: messageData(for: slack))

        // swiftlint:disable:next closure_body_length
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
                let string: String = HTTP.errorMessage(httpResponse.statusCode, for: url)
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

    /// Generate HTTP body data from the provided parameters.
    ///
    /// - Parameters:
    ///   - slack: The Slack configuration.
    /// - Returns: A `Data` object is successful, otherwise `nil`.
    private static func messageData(for slack: SlackConfiguration) -> Data? {

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
            "text": SlackConfiguration.defaultText
        ]

        guard let data: Data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            PrettyPrint.print("Invalid dictionary: \(dictionary)")
            return nil
        }

        return data
    }

    /// Upload a file to Slack.
    ///
    /// - Parameters:
    ///   - data:       The HTTP body data to upload.
    ///   - outputType: The output type (file extension) of the file to upload.
    ///   - slack:      The Slack configuration.
    ///   - timestamp:  The timestamp of a previous Slack message, used to append / reply via a thread.
    ///   - semaphore:  The common semaphore used to wait for operations to complete.
    private static func upload(_ data: Data, of outputType: OutputType, for slack: SlackConfiguration, timestamp: String, using semaphore: DispatchSemaphore) {

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

        // swiftlint:disable:next closure_body_length
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
                let string: String = HTTP.errorMessage(httpResponse.statusCode, for: url)
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

    /// Generate HTTP file data from the provided parameters.
    ///
    /// - Parameters:
    ///   - data:       The file data to upload.
    ///   - outputType: The output type (file extension) of the file to upload.
    ///   - slack:      The Slack configuration.
    ///   - timestamp:  The timestamp of a previous Slack message, used to append / reply via a thread.
    ///   - boundary:   A unique string used as a boundary to separate file parameters.
    /// - Returns: A `Data` object is successful, otherwise `nil`.
    private static func uploadData(from data: Data, of outputType: OutputType, for slack: SlackConfiguration, timestamp: String, boundary: String) -> Data? {

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
