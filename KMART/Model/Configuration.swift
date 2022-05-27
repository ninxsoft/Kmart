//
//  Configuration.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation
import Yams

/// Struct used to hold all configuration options.
struct Configuration {
    /// Report name.
    var name: String = "\(String.appName.capitalized) Report"
    /// Jamf Pro URL.
    var url: String = ""
    /// Jamf Pro API credentials.
    var credentials: String = ""
    /// Number of concurrent API requests.
    var requests: Int = 4
    /// Number of seconds before a timeout.
    var timeout: Double = 10
    /// List of report types to report on.
    var reports: [ReportType] = []
    /// Additional report options.
    var reportOptions: [ReportOptionType: Int] = [:]
    /// List of output types to export.
    var output: [OutputType: String] = [:]
    /// Slack configuration object.
    var slack: SlackConfiguration = SlackConfiguration([:])
    /// List of endpoints to report on, derived from the requested report types.
    var endpoints: [Endpoint] {
        let endpoints: [Endpoint] = reports.flatMap { $0.endpoints }
        return Array(Set(endpoints)).sorted { $0.identifier < $1.identifier }
    }

    /// Initialize a Configuration struct by passing in a custom `ConfigurationType` and path to a configuration file.
    ///
    /// - Parameters:
    ///   - type: Custom `ConfigurationType` (ie. `.json`, `.plist`, `.yaml`).
    ///   - path: Path to a configuration file.
    init?(_ type: ConfigurationType, path: String) {

        let url: URL = URL(fileURLWithPath: path)
        var dictionary: [String: Any] = [:]

        do {
            switch type {
            case .json:
                let data: Data = try Data(contentsOf: url)
                if let json: [String: Any] = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] {
                    dictionary = json
                }
            case .plist:
                let data: Data = try Data(contentsOf: url)
                var format: PropertyListSerialization.PropertyListFormat = .xml
                if let plist: [String: Any] = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: &format) as? [String: Any] {
                    dictionary = plist
                }
            case .yaml:
                let string: String = try String(contentsOf: url)
                if let yaml: [String: Any] = try Yams.load(yaml: string) as? [String: Any] {
                    dictionary = yaml
                }
            }
        } catch {
            PrettyPrint.print(error.localizedDescription, prefixColor: .red)
            return nil
        }

        guard configureSetup(dictionary) else {
            return nil
        }

        configureReports(dictionary["reports"] as? [String: Bool] ?? [:])
        configureReportOptions(dictionary["reports_options"] as? [String: Int] ?? [:])
        configureOutput(dictionary["output"] as? [String: String] ?? [:])
        configureSlack(dictionary["slack"] as? [String: Any] ?? [: ])
    }

    /// Set the default Jamf API configuration.
    ///
    /// - Parameters:
    ///   - dictionary: The dictionary containing the **Report** configuration options.
    private mutating func configureSetup(_ dictionary: [String: Any]) -> Bool {

        if let string: String = dictionary["name"] as? String {
            name = string
        }

        guard let urlString: String = dictionary["url"] as? String else {
            PrettyPrint.print("Missing 'url' key in configuration file.", prefixColor: .red)
            return false
        }

        url = urlString

        guard let credentialsString: String = dictionary["credentials"] as? String else {
            PrettyPrint.print("Missing 'credentials' key in configuration file.", prefixColor: .red)
            return false
        }

        credentials = credentialsString

        if let int: Int = dictionary["api_requests"] as? Int {
            requests = int
        }

        if let int: Int = dictionary["api_timeout"] as? Int {
            timeout = Double(int)
        }

        return true
    }

    /// Set the **Reports** configuration.
    ///
    /// - Parameters:
    ///   - dictionary: The dictionary containing the **Report** configuration options.
    private mutating func configureReports(_ dictionary: [String: Bool]) {

        for key in dictionary.keys {

            guard let type: ReportType = ReportType(rawValue: key),
                let boolean: Bool = dictionary[key],
                boolean else {
                continue
            }

            reports.append(type)
        }

        reports.sort { $0.identifier < $1.identifier }
    }

    /// Set the **Report Options** configuration.
    ///
    /// - Parameters:
    ///   - dictionary: The dictionary containing the **Report** configuration options.
    private mutating func configureReportOptions(_ dictionary: [String: Int]) {

        for key in dictionary.keys.sorted() {

            guard let type: ReportOptionType = ReportOptionType(rawValue: key),
                let int: Int = dictionary[key],
                int > 0 else {
                continue
            }

            reportOptions[type] = int
        }
    }

    /// Set the **Output** configuration.
    ///
    /// - Parameters:
    ///   - dictionary: The dictionary containing the **Output** configuration options.
    private mutating func configureOutput(_ dictionary: [String: String]) {

        for key in dictionary.keys.sorted() {

            guard let type: OutputType = OutputType(rawValue: key),
                let string: String = dictionary[key] else {
                continue
            }

            output[type] = string
        }
    }

    /// Set the **Slack** configuration.
    ///
    /// - Parameters:
    ///   - dictionary: The dictionary containing the **Slack** configuration options.
    private mutating func configureSlack(_ dictionary: [String: Any]) {
        slack = SlackConfiguration(dictionary)
    }
}
