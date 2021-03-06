//
//  String+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation

extension String {

    enum Color: String, CaseIterable {
        case black = "\u{001B}[0;30m"
        case red = "\u{001B}[0;31m"
        case green = "\u{001B}[0;32m"
        case yellow = "\u{001B}[0;33m"
        case blue = "\u{001B}[0;34m"
        case magenta = "\u{001B}[0;35m"
        case cyan = "\u{001B}[0;36m"
        case white = "\u{001B}[0;37m"
        case brightBlack = "\u{001B}[0;90m"
        case brightRed = "\u{001B}[0;91m"
        case brightGreen = "\u{001B}[0;92m"
        case brightYellow = "\u{001B}[0;93m"
        case brightBlue = "\u{001B}[0;94m"
        case brightMagenta = "\u{001B}[0;95m"
        case brightCyan = "\u{001B}[0;96m"
        case brightWhite = "\u{001B}[0;97m"
        case reset = "\u{001B}[0;0m"
    }

    static let appName: String = "kmart"
    static let identifier: String = "com.ninxsoft.\(appName)"
    static let abstract: String = "Kick-Ass Mac Admin Reporting Tool"
    static let discussion: String = "Generate kick-ass Jamf Pro reports."
    static let repositoryURL: String = "https://github.com/ninxsoft/\(appName)"
    static let latestReleaseURL: String = "https://api.github.com/repos/ninxsoft/\(appName)/releases/latest"

    var scriptType: ScriptType? {

        guard let line: String = self.components(separatedBy: .newlines).first else {
            return nil
        }

        return line.lowercased().contains("python") ? .python : .shell
    }

    func color(_ color: Color) -> String {
        color.rawValue + self + Color.reset.rawValue
    }

    func escapingMarkdown() -> String {
        self.replacingOccurrences(of: "[", with: "&#91;")
            .replacingOccurrences(of: "\\", with: "&#92;")
            .replacingOccurrences(of: "]", with: "&#93;")
            .replacingOccurrences(of: "_", with: "&#95;")
            .replacingOccurrences(of: "|", with: "&#124;")
    }

    func lintArray() -> [[String: Any]] {
        var dictionaries: [[String: Any]] = []

        for substring in self.components(separatedBy: .newlines) {
            let components: [String] = substring.components(separatedBy: ":")

            guard components.count == 4,
                let line: Int = Int(components[1]),
                let column: Int = Int(components[2]) else {
                continue
            }

            let codeAndMessage: String = components[3].trimmingCharacters(in: .whitespaces)

            guard let code: String = codeAndMessage.components(separatedBy: " ").first else {
                continue
            }

            let level: String = code.range(of: "^[CEF]", options: .regularExpression) != nil ? "error" : "warning"
            let message: String = codeAndMessage.replacingOccurrences(of: code, with: "").trimmingCharacters(in: .whitespaces)

            let dictionary: [String: Any] = [
                "level": level,
                "line": line,
                "column": column,
                "code": code,
                "message": message
            ]

            dictionaries.append(dictionary)
        }

        return dictionaries
    }

    func leftPadding(toLength: Int, withPad: String) -> String {
        String(String(reversed()).padding(toLength: toLength, withPad: withPad, startingAt: 0).reversed())
    }
}
