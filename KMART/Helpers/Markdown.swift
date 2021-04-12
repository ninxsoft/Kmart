//
//  Markdown.swift
//  KMART
//
//  Created by Nindi Gill on 29/3/21.
//

import Foundation
import Ink

struct Markdown {

    static func generateMarkdown(from dictionary: [String: Any], name: String, url: String) -> String {

        guard let reports: [String: Any] = dictionary["reports"] as? [String: Any] else {
            return ""
        }

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .long
        dateFormatter.timeZone = .current

        var string: String = ""
        string.append("# \(name)\n\n")
        string.append("#### Prepared on \(dateFormatter.string(from: Date()))\n\n")
        string.append("## Table of Contents\n\n")
        let endpoints: [Endpoint] = endpointSections(for: dictionary)

        for endpoint in endpoints {
            string.append("*   [\(endpoint.fullDescription)](#\(endpoint.markdownIdentifier))\n")
        }

        string.append("\n")

        for endpoint in endpoints {

            string.append("## \(endpoint.fullDescription)\n\n")

            var content: Bool = false

            for key in reports.keys.sorted() {

                if let type: ReportType = ReportType(rawValue: key),
                    type.endpoint == endpoint,
                    let items: [[String: Any]] = reports[key] as? [[String: Any]],
                    !items.isEmpty {
                    content = true
                    string.append("##### \(type.markdownDescription):\n\n")
                    string.append(tableHeader(for: type))

                    for item in items {
                        if let row: String = tableRow(type: type, dictionary: item, url: url) {
                            string.append(row)
                        }
                    }
                }
            }

            if !content {
                string.append("##### Nothing to report, everything looks in order!\n")
            }

            string.append("\n[Back to Table of Contents](#table-of-contents)\n\n")
        }

        return string
    }

    static func generateHTML(from dictionary: [String: Any], name: String, url: String) -> String {
        let markdown: String = generateMarkdown(from: dictionary, name: name, url: url)
        var parser: MarkdownParser = MarkdownParser()

        let modifier: Modifier = Modifier(target: .headings) { html, markdown in

            guard markdown.starts(with: "## ") else {
                return html
            }

            let string: String = markdown.replacingOccurrences(of: "## ", with: "")
            let identifier: String = string.lowercased().replacingOccurrences(of: " ", with: "-")
            return "<h2 id=\"\(identifier)\">\(string)</h2>"
        }

        parser.addModifier(modifier)

        let string: String = wrapInHTML(string: parser.html(from: markdown), name: name)
        return string
    }

    private static func endpointSections(for dictionary: [String: Any]) -> [Endpoint] {

        guard let reports: [String: Any] = dictionary["reports"] as? [String: Any] else {
            return []
        }

        var endpoints: [Endpoint] = []

        for key in reports.keys.sorted() {
            if let type: ReportType = ReportType(rawValue: key) {
                endpoints.append(type.endpoint)
            }
        }

        return Array(Set(endpoints)).sorted { $0.fullDescription.lowercased() < $1.fullDescription.lowercased() }
    }

    private static func tableHeader(for type: ReportType) -> String {

        var string: String = ""

        switch type {
        case .macDevicesDuplicateNames, .macDevicesDuplicateSerialNumbers, .macDevicesLastCheckIn, .macDevicesLastInventory, .mobileDevicesLastInventory:
            string.append("| **ID** | **Name** | **Serial Number** |\n")
            string.append("| :----: | :------- | :---------------: |\n")
        case .macExtensionAttributesLinterWarnings, .macScriptsLinterWarnings:
            string.append("| **ID** | **Name** | **Line** | **Column** | **Warning** | **Reference** |\n")
            string.append("| :----: | :------- | :------: | :--------: | :---------- | :-----------: |\n")
        case .macExtensionAttributesLinterErrors, .macScriptsLinterErrors:
            string.append("| **ID** | **Name** | **Line** | **Column** | **Error** | **Reference** |\n")
            string.append("| :----: | :------- | :------: | :--------: | :-------- | :-----------: |\n")
        default:
            string.append("| **ID** | **Name** |\n")
            string.append("| :----: | :------- |\n")
        }

        return string
    }

    private static func tableRow(type: ReportType, dictionary: [String: Any], url: String) -> String? {

        guard let identifier: Int = dictionary["id"] as? Int,
            let name: String = dictionary["name"] as? String else {
            return nil
        }

        let link: String = "\(url)/\(type.jamfProSlug)\(identifier)"
        let formattedName: String = name.escapingMarkdown()

        switch type {
        case .macDevicesDuplicateNames, .macDevicesDuplicateSerialNumbers, .macDevicesLastCheckIn, .macDevicesLastInventory, .mobileDevicesLastInventory:
            guard let serialNumber: String = dictionary["serial_number"] as? String else {
                return nil
            }

            return "| [\(identifier)](\(link)) | \(formattedName) | \(serialNumber) |\n"
        case .macExtensionAttributesLinterWarnings, .macScriptsLinterWarnings, .macExtensionAttributesLinterErrors, .macScriptsLinterErrors:
            guard let items: [[String: Any]] = dictionary[[.macExtensionAttributesLinterWarnings, .macScriptsLinterWarnings].contains(type) ? "warnings" : "errors"] as? [[String: Any]] else {
                return nil
            }

            var string: String = ""

            for (index, item) in items.enumerated() {

                guard let line: Int = item["line"] as? Int,
                    let column: Int = item["column"] as? Int,
                    let code: Int = item["code"] as? Int,
                    let message: String = item["message"] as? String  else {
                    return nil
                }

                let formattedCode: String = "https://github.com/koalaman/shellcheck/wiki/SC\(code)"
                let formattedMessage: String = message.escapingMarkdown().trimmingCharacters(in: .newlines)

                if index == 0 {
                    string.append("| [\(identifier)](\(link)) | \(formattedName) | \(line) | \(column) | \(formattedMessage) | [\(code)](\(formattedCode)) |\n")
                } else {
                    string.append("|  |  | \(line) | \(column) | \(formattedMessage) | [\(code)](\(formattedCode)) |\n")
                }
            }

            return string
        default:
            return "| [\(identifier)](\(link)) | \(formattedName) |\n"
        }
    }

    private static func wrapInHTML(string: String, name: String) -> String {
        let prefix: String = """
        <!doctype html>
        <html lang="en">
        <head>
            <meta charset="utf-8">
            <title>\(name)</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/4.0.0/github-markdown.min.css">
            <style>
                .markdown-body {
                    box-sizing: border-box;
                    min-width: 200px;
                    max-width: 980px;
                    margin: 0 auto;
                    padding: 45px;
                }

                @media (max-width: 767px) {
                    .markdown-body {
                        padding: 15px;
                    }
                }
            </style>
        </head>
        <body class="markdown-body">
        """
        let suffix: String = """
        </body>
        </html>
        """
        let string: String = prefix + string + suffix
        return string
    }
}
