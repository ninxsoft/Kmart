//
//  EBook.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct EBook: Codable {
    var id: Int = -1
    var name: String = ""
    var category: Int = -1
    var macTargets: MacTargets = MacTargets()
    var macExclusions: MacExclusions = MacExclusions()
    var mobileTargets: MobileTargets = MobileTargets()
    var mobileExclusions: MobileExclusions = MobileExclusions()
    var limitations: Limitations = Limitations()
    var scope: Bool {
        macTargets.scope || macExclusions.scope || mobileTargets.scope || mobileExclusions.scope || limitations.scope
    }
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
