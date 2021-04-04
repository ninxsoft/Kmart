//
//  SmartGroup.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct SmartGroup: Codable {
    // swiftlint:disable:next identifier_name
    var id: Int = -1
    var name: String = ""
    var criteria: [Criterion] = []
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
