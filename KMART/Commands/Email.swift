//
//  Email.swift
//  KMART
//
//  Created by Nindi Gill on 3/4/21.
//

import Foundation

struct Email {

    var enabled: Bool = false
    var hostname: String = ""
    var port: Int32 = 587
    var username: String = ""
    var password: String = ""
    var name: String = ""
    var sender: String = ""
    var recipients: [String] = []
    var carbonCopy: [String] = []
    var blindCarbonCopy: [String] = []
    var subject: String = ""
    var body: String = ""
    var attachments: [OutputType: String] = [:]

    init(_ dictionary: [String: Any] = [:]) {
        enabled = dictionary["enabled"] as? Bool ?? false
        hostname = dictionary["hostname"] as? String ?? ""
        port = dictionary["port"] as? Int32 ?? 0
        username = dictionary["username"] as? String ?? ""
        password = dictionary["password"] as? String ?? ""
        name = dictionary["sender_name"] as? String ?? ""
        sender = dictionary["sender_email"] as? String ?? ""
        recipients = dictionary["recipients"] as? [String] ?? []
        carbonCopy = dictionary["cc"] as? [String] ?? []
        blindCarbonCopy = dictionary["bcc"] as? [String] ?? []
        subject = dictionary["subject"] as? String ?? ""
        body = dictionary["body"] as? String ?? ""

        if let attachmentsDictionary: [String: String] = dictionary["attachments"] as? [String: String] {

            for type in OutputType.allCases {
                if let string: String = attachmentsDictionary[type.rawValue] {
                    attachments[type] = string
                }
            }
        }
    }
}
