//
//  StaticGroup.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct StaticGroup: Codable {
    var id: Int = -1
    var name: String = ""
    var devices: [Int] = []
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
