//
//  Slack.swift
//  KMART
//
//  Created by Nindi Gill on 20/8/21.
//

import Foundation

struct Slack {

    static let defaultText: String = "KMART Report(s) have been uploaded :partying_face:"

    var enabled: Bool = false
    var token: String = ""
    var channel: String = ""
    var text: String = ""
    var attachments: [OutputType: Bool] = [:]

    init(_ dictionary: [String: Any] = [:]) {
        enabled = dictionary["enabled"] as? Bool ?? false
        token = dictionary["token"] as? String ?? ""
        channel = dictionary["channel"] as? String ?? ""
        text = dictionary["text"] as? String ?? Slack.defaultText

        if let attachmentsDictionary: [String: Any] = dictionary["attachments"] as? [String: Any] {

            for type in OutputType.allCases {
                if let boolean: Bool = attachmentsDictionary[type.rawValue] as? Bool {
                    attachments[type] = boolean
                }
            }
        }
    }
}
