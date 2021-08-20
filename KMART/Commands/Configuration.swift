//
//  Configuration.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import ArgumentParser
import Foundation
import Yams

enum ConfigurationType: String, ExpressibleByArgument {
    case json = "JSON"
    case plist = "Property List"
    case yaml = "YAML"
}

enum ConfigurationError: Error {
    case invalidFile
}

struct Configuration {
    var name: String = "\(String.appName.capitalized) Report"
    var url: String = ""
    var credentials: String = ""
    var authorization: String {
        "Basic \(credentials)"
    }
    var requests: Int = 4
    var timeout: Double = 10
    var reports: [ReportType] = []
    var reportOptions: [ReportOptionType: Int] = [:]
    var output: [OutputType: String] = [:]
    var email: Email = Email([:])
    var endpoints: [Endpoint] {
        let endpoints: [Endpoint] = reports.flatMap { $0.endpoints }
        return Array(Set(endpoints)).sorted { $0.identifier < $1.identifier }
    }

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
            PrettyPrint.print(.error, string: "\(error.localizedDescription)")
            return nil
        }

        guard configureSetup(dictionary) else {
            return nil
        }

        configureReports(dictionary["reports"] as? [String: Bool])
        configureReportOptions(dictionary["reports_options"] as? [String: Int])
        configureOutput(dictionary["output"] as? [String: String])
        configureEmail(dictionary["email"] as? [String: Any])
    }

    private mutating func configureSetup(_ dictionary: [String: Any]) -> Bool {

        if let string: String = dictionary["name"] as? String {
            name = string
        }

        guard let urlString: String = dictionary["url"] as? String else {
            PrettyPrint.print(.error, string: "Missing 'url' key in configuration file.")
            return false
        }

        url = urlString

        guard let credentialsString: String = dictionary["credentials"] as? String else {
            PrettyPrint.print(.error, string: "Missing 'credentials' key in configuration file.")
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

    private mutating func configureReports(_ dictionary: [String: Bool]?) {

        guard let dictionary: [String: Bool] = dictionary else {
            return
        }

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

    private mutating func configureReportOptions(_ dictionary: [String: Int]?) {

        guard let dictionary: [String: Int] = dictionary else {
            return
        }

        for key in dictionary.keys.sorted() {

            guard let type: ReportOptionType = ReportOptionType(rawValue: key),
                let int: Int = dictionary[key],
                int > 0 else {
                continue
            }

            reportOptions[type] = int
        }
    }

    private mutating func configureOutput(_ dictionary: [String: String]?) {

        guard let dictionary: [String: String] = dictionary else {
            return
        }

        for key in dictionary.keys.sorted() {

            guard let type: OutputType = OutputType(rawValue: key),
                let string: String = dictionary[key] else {
                continue
            }

            output[type] = string
        }
    }

    private mutating func configureEmail(_ dictionary: [String: Any]?) {

        guard let dictionary: [String: Any] = dictionary else {
            return
        }

        email = Email(dictionary)
    }
}
