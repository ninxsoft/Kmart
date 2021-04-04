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
    var code: Int = -1
    var message: String = ""
    var dictionary: [String: Any] {
        [
            "line": line,
            "column": column,
            "code": code,
            "message": message
        ]
    }
}
