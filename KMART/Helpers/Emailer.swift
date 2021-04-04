//
//  Emailer.swift
//  KMART
//
//  Created by Nindi Gill on 30/3/21.
//

import Foundation
import SwiftSMTP

struct Emailer {

    static func email(_ reports: Reports, using configuration: Configuration) {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        let email: Email = configuration.email
        let smtp: SMTP = SMTP(hostname: email.hostname, email: email.username, password: email.password, port: email.port)
        let sender: Mail.User = Mail.User(name: email.name, email: email.sender)
        let recipients: [Mail.User] = email.recipients.map { Mail.User(name: "", email: $0) }
        let carbonCopy: [Mail.User] = email.carbonCopy.map { Mail.User(name: "", email: $0) }
        let blindCarbonCopy: [Mail.User] = email.blindCarbonCopy.map { Mail.User(name: "", email: $0) }
        let subject: String = email.subject
        var attachments: [Attachment] = []

        if let data: Data = reports.data(type: .html, using: configuration),
            let string: String = String(data: data, encoding: .utf8) {
            let attachment: Attachment = Attachment(htmlContent: string)
            attachments.append(attachment)
        }

        if let string: String = email.attachments[.json],
            let data: Data = reports.data(type: .json, using: configuration) {
            let attachment: Attachment = Attachment(data: data, mime: "application/json", name: string)
            attachments.append(attachment)
        }

        if let string: String = email.attachments[.propertyList],
            let data: Data = reports.data(type: .propertyList, using: configuration) {
            let attachment: Attachment = Attachment(data: data, mime: "application/x-plist", name: string)
            attachments.append(attachment)
        }

        if let string: String = email.attachments[.yaml],
            let data: Data = reports.data(type: .yaml, using: configuration) {
            let attachment: Attachment = Attachment(data: data, mime: "application/x-yaml", name: string)
            attachments.append(attachment)
        }

        if let string: String = email.attachments[.markdown],
            let data: Data = reports.data(type: .markdown, using: configuration) {
            let attachment: Attachment = Attachment(data: data, mime: "text/markdown", name: string)
            attachments.append(attachment)
        }

        if let string: String = email.attachments[.html],
            let data: Data = reports.data(type: .html, using: configuration) {
            let attachment: Attachment = Attachment(data: data, mime: "text/html", name: string)
            attachments.append(attachment)
        }

        let mail: Mail = Mail(from: sender, to: recipients, cc: carbonCopy, bcc: blindCarbonCopy, subject: subject, attachments: attachments)

        PrettyPrint.print(.info, string: "Emailing Report: \(subject)")
        smtp.send(mail) { error in

            if let error: Error = error {
                PrettyPrint.print(.error, string: error.localizedDescription)
            }

            semaphore.signal()
        }

        semaphore.wait()
    }
}
