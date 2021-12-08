//
//  MacRestrictedSoftware.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MacRestrictedSoftware: Codable {
    var id: Int = -1
    var name: String = ""
    var macTargets: MacTargets = MacTargets()
    var macExclusions: MacExclusions = MacExclusions()
    var scope: Bool {
        macTargets.scope || macExclusions.scope
    }
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
