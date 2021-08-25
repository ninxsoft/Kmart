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
}
