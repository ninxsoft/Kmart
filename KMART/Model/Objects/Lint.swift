//
//  Lint.swift
//  KMART
//
//  Created by Nindi Gill on 1/3/21.
//

import Foundation

enum LintLevel: String, Codable {
    case lintStyle = "style"
    case lintInfo = "info"
    case lintWarning = "warning"
    case lintError = "error"

    var identifier: String {
        rawValue
    }
}

struct Lint: Codable {
    var level: LintLevel = .lintStyle
    var line: Int = -1
    var column: Int = -1
    var code: String = ""
    var message: String = ""
    var dictionary: [String: Any] {
        [
            "line": line,
            "column": column,
            "code": code,
            "message": message
        ]
    }

    static func url(for code: String) -> String {

        if code.range(of: "^[CF]", options: .regularExpression) != nil {
            return "https://flake8.pycqa.org/en/latest/user/error-codes.html"
        } else if code.range(of: "^[EW]", options: .regularExpression) != nil {
            return "https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes"
        } else {
            return "https://github.com/koalaman/shellcheck/wiki/SC\(code)"
        }
    }
}
