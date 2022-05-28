//
//  Limitations.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation
import SWXMLHash

struct Limitations: Codable, XMLObjectDeserialization {
    var users: [String] = []
    var userGroups: [String] = []
    var networkSegments: [Int] = []
    var iBeacons: [Int] = []
    var scope: Bool {
        !users.isEmpty ||
        !userGroups.isEmpty ||
        !networkSegments.isEmpty ||
        !iBeacons.isEmpty
    }

    static func deserialize(_ node: XMLIndexer) throws -> Limitations {

        var networkSegments: [Int] = []
        var iBeacons: [Int] = []

        for element in node["network_segments"].all {

            guard let child = element["network_segment"]["id"].element,
                let networkSegment: Int = Int(child.text) else {
                continue
            }

            networkSegments.append(networkSegment)
        }

        for element in node["ibeacons"].all {

            guard let child = element["ibeacon"]["id"].element,
                let iBeacon: Int = Int(child.text) else {
                continue
            }

            iBeacons.append(iBeacon)
        }

        return Limitations(networkSegments: networkSegments, iBeacons: iBeacons)
    }
}
