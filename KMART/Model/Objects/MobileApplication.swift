//
//  MobileApplication.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MobileApplication: Codable {
    // swiftlint:disable:next identifier_name
    var id: Int = -1
    var name: String = ""
    var category: Int = -1
    var mobileTargets: MobileTargets = MobileTargets()
    var mobileExclusions: MobileExclusions = MobileExclusions()
    var limitations: Limitations = Limitations()
    var vppTotal: Int = -1
    var vppUsed: Int = -1
    var vppRemaining: Int {
        vppTotal - vppUsed
    }
    var scope: Bool {
        mobileTargets.scope || mobileExclusions.scope || limitations.scope
    }
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
