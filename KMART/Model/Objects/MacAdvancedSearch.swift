//
//  MacAdvancedSearch.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MacAdvancedSearch: Codable {
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
