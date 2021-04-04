//
//  MacScript.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MacScript: Codable {
    // swiftlint:disable:next identifier_name
    var id: Int = -1
    var name: String = ""
    var category: String = ""
    var parameters: [String] = []
    var scriptContents: String = ""
    var linterWarnings: [Lint] = []
    var linterErrors: [Lint] = []
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
    var linterWarningsDictionary: [String: Any] {
        [
            "id": id,
            "name": name,
            "warnings": linterWarnings.map { $0.dictionary }
        ]
    }
    var linterErrorsDictionary: [String: Any] {
        [
            "id": id,
            "name": name,
            "errors": linterErrors.map { $0.dictionary }
        ]
    }
}
