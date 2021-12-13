//
//  NetworkSegment.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct NetworkSegment: Codable {
    var id: Int = -1
    var name: String = ""
    var building: String = ""
    var department: String = ""
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
