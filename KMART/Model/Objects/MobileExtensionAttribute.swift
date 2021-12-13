//
//  MobileExtensionAttribute.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MobileExtensionAttribute: Codable {
    var id: Int
    var name: String
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
