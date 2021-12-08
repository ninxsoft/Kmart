//
//  MacPrinter.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MacPrinter: Codable {
    var id: Int = -1
    var name: String = ""
    var category: String = ""
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
