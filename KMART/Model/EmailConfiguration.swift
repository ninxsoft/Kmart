//
//  EmailConfiguration.swift
//  KMART
//
//  Created by Nindi Gill on 3/4/21.
//

import Foundation

/// Struct used to hold Email configuration.
struct EmailConfiguration {

    /// Set to `true` to enable reporting via Email.
    var enabled: Bool = false
    /// Email hostname
    var hostname: String = ""
    /// Email port
    var port: Int32 = 587
    /// Email username
    var username: String = ""
    /// Email password
    var password: String = ""
    /// Email sender name
    var name: String = ""
    /// Email sender
    var sender: String = ""
    /// Email list of recipients
    var recipients: [String] = []
    /// Email list of CC recipients
    var carbonCopy: [String] = []
    /// Email list of BCC recipients
    var blindCarbonCopy: [String] = []
    /// Email subject
    var subject: String = ""
    /// Email body
    var body: String = ""
    /// Email attachments
    var attachments: [OutputType: String] = [:]

    /// Initialize an Email struct by passing in a custom dictionary.
    ///
    /// - Parameters:
    ///   - dictionary: Custom dictionary containing Email configuration properties.
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
