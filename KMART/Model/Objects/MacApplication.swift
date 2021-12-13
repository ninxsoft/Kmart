//
//  MacApplication.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MacApplication: Codable {
    var id: Int = -1
    var name: String = ""
    var category: Int = -1
    var macTargets: MacTargets = MacTargets()
    var macExclusions: MacExclusions = MacExclusions()
    var limitations: Limitations = Limitations()
    var vppTotal: Int = -1
    var vppUsed: Int = -1
    var vppRemaining: Int {
        vppTotal - vppUsed
    }
    var scope: Bool {
        macTargets.scope || macExclusions.scope || limitations.scope
    }
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
