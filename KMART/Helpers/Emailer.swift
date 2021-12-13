//
//  Emailer.swift
//  KMART
//
//  Created by Nindi Gill on 30/3/21.
//

import Foundation
import SwiftSMTP

/// Struct used to perform all **Email** operations.
struct Emailer {

    /// Send an email with an attached report.
    ///
    /// - Parameters:
    ///   - reports:       The reports to send via Email.
    ///   - configuration: The configuration containing email settings.
    static func email(_ reports: Reports, using configuration: Configuration) {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        let email: EmailConfiguration = configuration.email
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

        for outputType in OutputType.allCases {

            if let string: String = email.attachments[outputType],
                let data: Data = reports.data(type: outputType, using: configuration) {
                let attachment: Attachment = Attachment(data: data, mime: outputType.mimeType, name: string)
                attachments.append(attachment)
            }
        }

        let mail: Mail = Mail(from: sender, to: recipients, cc: carbonCopy, bcc: blindCarbonCopy, subject: subject, attachments: attachments)

        PrettyPrint.print("Sending Report(s) via Email")
        smtp.send(mail) { error in

            if let error: Error = error {
                PrettyPrint.print(error.localizedDescription)
            }

            semaphore.signal()
        }

        semaphore.wait()
    }
}
