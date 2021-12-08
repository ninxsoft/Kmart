//
//  MobileConfigurationProfile.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MobileConfigurationProfile: Codable {
    var id: Int = -1
    var name: String = ""
    var category: Int = -1
    var mobileTargets: MobileTargets = MobileTargets()
    var mobileExclusions: MobileExclusions = MobileExclusions()
    var limitations: Limitations = Limitations()
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
