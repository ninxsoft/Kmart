//
//  SlackConfiguration.swift
//  KMART
//
//  Created by Nindi Gill on 20/8/21.
//

import Foundation

/// Struct used to hold Slack configuration.
struct SlackConfiguration {

    /// Default upload text message.
    static let defaultText: String = "KMART Report(s) have been uploaded."

    /// Set to `true` to enable reporting via Slack.
    var enabled: Bool = false
    /// Slack API token.
    var token: String = ""
    /// Channel where messages will be sent.
    var channel: String = ""
    /// Upload text message.
    var text: String = ""
    /// Slack attachments
    var attachments: [OutputType] = []

    /// Initialize a Slack struct by passing in a custom dictionary.
    ///
    /// - Parameters:
    ///   - dictionary: Custom dictionary containing Slack configuration properties.
    init(_ dictionary: [String: Any] = [:]) {
        enabled = dictionary["enabled"] as? Bool ?? false
        token = dictionary["token"] as? String ?? ""
        channel = dictionary["channel"] as? String ?? ""
        text = dictionary["text"] as? String ?? SlackConfiguration.defaultText

        if let array: [String] = dictionary["attachments"] as? [String] {

            for item in array {
                if let attachment: OutputType = OutputType(rawValue: item) {
                    attachments.append(attachment)
                }
            }
        }
    }
}
