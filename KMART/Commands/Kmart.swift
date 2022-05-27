//
//  Kmart.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import ArgumentParser
import Foundation

struct Kmart: AsyncParsableCommand {
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

    mutating func runAsync() async throws {

        if !json.isEmpty {
            try await execute(type: .json, path: json)
        } else if !plist.isEmpty {
            try await execute(type: .plist, path: plist)
        } else if !yaml.isEmpty {
            try await execute(type: .yaml, path: yaml)
        } else if version {
            Version.run()
        } else {
            let string: String = Kmart.helpMessage()
            print(string)
        }
    }

    private func execute(type: ConfigurationType, path: String) async throws {

        guard let configuration: Configuration = Configuration(type, path: path) else {
            throw KmartError.invalidFile
        }

        PrettyPrint.printHeader("RETRIEVING JAMF PRO API ENDPOINTS")
        let apiStart: Date = Date()
        let objects: Objects = await HTTP.retrieveObjects(using: configuration)
        let apiEnd: Date = Date()
        let apiString: String = String(format: "Total Time: %.1f seconds", apiEnd.timeIntervalSince(apiStart))
        PrettyPrint.print(apiString)

        PrettyPrint.printHeader("GENERATING REPORTS")
        let reportPrefix: PrettyPrint.Prefix = configuration.slack.enabled ? .default : .ending
        let reportStart: Date = Date()
        let reports: Reports = Reporter.generateReports(from: objects, using: configuration)
        reports.saveToDisk(using: configuration)
        let reportEnd: Date = Date()
        let reportString: String = String(format: "Total Time: %.1f seconds", reportEnd.timeIntervalSince(reportStart))
        PrettyPrint.print(reportString, prefix: reportPrefix)

        if configuration.slack.enabled {
            PrettyPrint.printHeader("SENDING VIA SLACK")
            let slackStart: Date = Date()
            await Slacker.send(reports, using: configuration)
            let slackEnd: Date = Date()
            let slackString: String = String(format: "Total Time: %.1f seconds", slackEnd.timeIntervalSince(slackStart))
            PrettyPrint.print(slackString, prefix: .ending)
        }
    }
}
