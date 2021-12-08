//
//  IBeacon.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct IBeacon: Codable {
    var id: Int = -1
    var name: String = ""
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
