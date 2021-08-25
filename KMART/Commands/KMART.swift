//
//  KMART.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import ArgumentParser
import Foundation

struct KMART: ParsableCommand {
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: .abstract, discussion: .discussion)

    @Option(name: .shortAndLong, help: """
    JSON configuration file.
    """)
    var json: String = ""

    @Option(name: .shortAndLong, help: """
    Property List configuration file.
    """)
    var plist: String = ""

    @Option(name: .shortAndLong, help: """
    YAML configuration file.
    """)
    var yaml: String = ""

    @Flag(name: .shortAndLong, help: "Display the version of \(String.appName).")
    var version: Bool = false

    mutating func run() throws {

        if !json.isEmpty {
            try execute(type: .json, path: json)
        } else if !plist.isEmpty {
        try execute(type: .plist, path: plist)
        } else if !yaml.isEmpty {
            try execute(type: .yaml, path: yaml)
        } else if version {
            Version.run()
        } else {
            let string: String = KMART.helpMessage()
            print(string)
        }
    }

    private func execute(type: ConfigurationType, path: String) throws {

        guard let configuration: Configuration = Configuration(type, path: path) else {
            throw ConfigurationError.invalidFile
        }

        let apiStart: Date = Date()
        let objects: Objects = HTTP.retrieveObjects(using: configuration)
        let apiEnd: Date = Date()
        PrettyPrint.print(.info, string: String(format: "Total API Retrieval Time: %.1f seconds", apiEnd.timeIntervalSince(apiStart)))
        let reportStart: Date = Date()
        let reports: Reports = Reporter.generateReports(from: objects, using: configuration)
        reports.saveToDisk(using: configuration)
        let reportEnd: Date = Date()
        PrettyPrint.print(.info, string: String(format: "Total Reporting Time: %.1f seconds", reportEnd.timeIntervalSince(reportStart)))

        if configuration.email.enabled {
            let emailStart: Date = Date()
            Emailer.email(reports, using: configuration)
            let emailEnd: Date = Date()
            PrettyPrint.print(.info, string: String(format: "Total Email Time: %.1f seconds", emailEnd.timeIntervalSince(emailStart)))
        }

        if configuration.slack.enabled {
            let slackStart: Date = Date()
            Slacker.send(reports, using: configuration)
            let slackEnd: Date = Date()
            PrettyPrint.print(.info, string: String(format: "Total Slack Time: %.1f seconds", slackEnd.timeIntervalSince(slackStart)))
        }
    }
}
