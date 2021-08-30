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

        PrettyPrint.printHeader("JAMF PRO API")
        let apiStart: Date = Date()
        let objects: Objects = HTTP.retrieveObjects(using: configuration)
        let apiEnd: Date = Date()
        let apiString: String = String(format: "Total Jamf Pro API Retrieval Time: %.1f seconds", apiEnd.timeIntervalSince(apiStart))
        PrettyPrint.print(apiString)

        PrettyPrint.printHeader("REPORTS")
        let reportPrefix: String = configuration.email.enabled || configuration.slack.enabled ? "  ├─ " : "  └─ "
        let reportStart: Date = Date()
        let reports: Reports = Reporter.generateReports(from: objects, using: configuration)
        reports.saveToDisk(using: configuration)
        let reportEnd: Date = Date()
        let reportString: String = String(format: "Total Report Generation Time: %.1f seconds", reportEnd.timeIntervalSince(reportStart))
        PrettyPrint.print(reportString, prefix: reportPrefix)

        if configuration.email.enabled {
            PrettyPrint.printHeader("EMAIL")
            let emailPrefix: String = configuration.slack.enabled ? "  ├─ " : "  └─ "
            let emailStart: Date = Date()
            Emailer.email(reports, using: configuration)
            let emailEnd: Date = Date()
            let emailString: String = String(format: "Total Email Time: %.1f seconds", emailEnd.timeIntervalSince(emailStart))
            PrettyPrint.print(emailString, prefix: emailPrefix)
        }

        if configuration.slack.enabled {
            PrettyPrint.printHeader("SLACK")
            let slackPrefix: String = "  └─ "
            let slackStart: Date = Date()
            Slacker.send(reports, using: configuration)
            let slackEnd: Date = Date()
            let slackString: String = String(format: "Total Slack Time: %.1f seconds", slackEnd.timeIntervalSince(slackStart))
            PrettyPrint.print(slackString, prefix: slackPrefix)
        }
    }
}
