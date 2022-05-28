//
//  MacPatchPolicy.swift
//  KMART
//
//  Created by Nindi Gill on 28/5/2022.
//

import Foundation
import SWXMLHash

struct MacPatchPolicy: Codable, XMLObjectDeserialization {
    var id: Int = -1
    var name: String = ""
    var enabled: Bool = false
    var macTargets: MacTargets = MacTargets()
    var macExclusions: MacExclusions = MacExclusions()
    var limitations: Limitations = Limitations()
    var scope: Bool {
        macTargets.scope || macExclusions.scope || limitations.scope
    }
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }

    static func deserialize(_ node: XMLIndexer) throws -> MacPatchPolicy {
        try MacPatchPolicy(
            id: node["patch_policy"]["general"]["id"].value(),
            name: node["patch_policy"]["general"]["name"].value(),
            enabled: node["patch_policy"]["general"]["enabled"].value(),
            macTargets: MacTargets.deserialize(node["patch_policy"]["scope"]),
            macExclusions: MacExclusions.deserialize(node["patch_policy"]["scope"]["exclusions"]),
            limitations: Limitations.deserialize(node["patch_policy"]["scope"]["limitations"])
        )
    }
}
