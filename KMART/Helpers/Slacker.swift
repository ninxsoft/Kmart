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
    static func send(_ reports: Reports, using configuration: Configuration) async {
        let slack: SlackConfiguration = configuration.slack

        PrettyPrint.print("Sending Report(s) via Slack")

        guard let timestamp: String = await message(slack) else {
            return
        }

        for attachment in slack.attachments {
            if let data: Data = reports.data(type: attachment, using: configuration) {
                await upload(data, of: attachment, for: slack, timestamp: timestamp)
            }
        }
    }

    /// Send a Slack message.
    ///
    /// - Parameters:
    ///   - slack:     The Slack configuration.
    /// - Returns: A timestamp `String` if successful, otherwise `nil`.
    private static func message(_ slack: SlackConfiguration) async -> String? {

        guard let url: URL = URL(string: chatPostMessageURL) else {
            PrettyPrint.print("Invalid URL: \(chatPostMessageURL)", prefixColor: .red)
            return nil
        }

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(slack.token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = messageData(for: slack)

        do {
            let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                PrettyPrint.print("Unable to get response from URL: \(url)", prefixColor: .red)
                return nil
            }

            guard httpResponse.statusCode == 200 else {
                let string: String = HTTP.errorMessage(httpResponse.statusCode, for: url)
                PrettyPrint.print(string, prefixColor: .red)
                return nil
            }

            guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                PrettyPrint.print("Invalid response data from URL: \(url)", prefixColor: .red)
                return nil
            }

            if let error: String = dictionary["error"] as? String {
                PrettyPrint.print("Error response: \(error)", prefixColor: .red)
                return nil
            }

            if let warning: String = dictionary["warning"] as? String {
                PrettyPrint.print("Warning response: \(warning)", prefixColor: .red)
            }

            guard let timestamp: String = dictionary["ts"] as? String else {
                PrettyPrint.print("Missing 'ts' key in response dictionary", prefixColor: .red)
                return nil
            }

            return timestamp
        } catch {
            PrettyPrint.print(error.localizedDescription, prefixColor: .red)
            return nil
        }
    }

    /// Generate HTTP body data from the provided parameters.
    ///
    /// - Parameters:
    ///   - slack: The Slack configuration.
    /// - Returns: A `Data` object is successful, otherwise `nil`.
    private static func messageData(for slack: SlackConfiguration) -> Data? {

        let block: [String: Any] = [
            "type": "section",
            "text": [
                "type": "mrkdwn",
                "text": slack.text
            ]
        ]

        let dictionary: [String: Any] = [
            "channel": slack.channel,
            "blocks": [block],
            "text": SlackConfiguration.defaultText
        ]

        guard let data: Data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            PrettyPrint.print("Invalid dictionary: \(dictionary)", prefixColor: .red)
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
    private static func upload(_ data: Data, of outputType: OutputType, for slack: SlackConfiguration, timestamp: String) async {

        guard let url: URL = URL(string: filesUploadURL) else {
            PrettyPrint.print("Invalid URL: \(filesUploadURL)", prefixColor: .red)
            return
        }

        let boundary: String = "\(String.identifier).\(UUID().uuidString)"
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(slack.token)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = uploadData(from: data, of: outputType, for: slack, timestamp: timestamp, boundary: boundary)

        PrettyPrint.print("Uploading \(outputType.description) report via Slack")

        do {
            let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                PrettyPrint.print("Unable to get response from URL: \(url)", prefixColor: .red)
                return
            }

            guard httpResponse.statusCode == 200 else {
                let string: String = HTTP.errorMessage(httpResponse.statusCode, for: url)
                PrettyPrint.print(string, prefixColor: .red)
                return
            }

            guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                PrettyPrint.print("Invalid response data from URL: \(url)", prefixColor: .red)
                return
            }

            if let error: String = dictionary["error"] as? String {
                PrettyPrint.print("Error response: \(error)", prefixColor: .red)
            }

            if let warning: String = dictionary["warning"] as? String {
                PrettyPrint.print("Warning response: \(warning)", prefixColor: .red)
            }
        } catch {
            PrettyPrint.print(error.localizedDescription, prefixColor: .red)
        }
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
            PrettyPrint.print("Invalid report file data", prefixColor: .red)
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
