//
//  MacPatchSoftwareTitle.swift
//  KMART
//
//  Created by Nindi Gill on 27/5/2022.
//

import Foundation

struct MacPatchSoftwareTitle: Codable {
    var id: Int = -1
    var name: String = ""
    var category: Int = -1
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name,
            "category": category
        ]
    }
}
