//
//  Limitations.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct Limitations: Codable {
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
}
