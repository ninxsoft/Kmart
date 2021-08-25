//
//  Slack.swift
//  KMART
//
//  Created by Nindi Gill on 20/8/21.
//

import Foundation

struct Slack {

    static let defaultText: String = "KMART Report(s) have been uploaded."

    var enabled: Bool = false
    var token: String = ""
    var channel: String = ""
    var text: String = ""
    var attachments: [OutputType] = []

    init(_ dictionary: [String: Any] = [:]) {
        enabled = dictionary["enabled"] as? Bool ?? false
        token = dictionary["token"] as? String ?? ""
        channel = dictionary["channel"] as? String ?? ""
        text = dictionary["text"] as? String ?? Slack.defaultText

        if let array: [String] = dictionary["attachments"] as? [String] {

            for item in array {
                if let attachment: OutputType = OutputType(rawValue: item) {
                    attachments.append(attachment)
                }
            }
        }
    }
}
