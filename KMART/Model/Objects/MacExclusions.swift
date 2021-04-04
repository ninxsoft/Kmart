//
//  MacExclusions.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct MacExclusions: Codable {
    var buildings: [Int] = []
    var departments: [Int] = []
    var devices: [Int] = []
    var deviceGroups: [Int] = []
    var users: [String] = []
    var userGroups: [String] = []
    var networkSegments: [Int] = []
    var iBeacons: [Int] = []
    var scope: Bool {
        !buildings.isEmpty ||
        !departments.isEmpty ||
        !devices.isEmpty ||
        !deviceGroups.isEmpty ||
        !users.isEmpty ||
        !userGroups.isEmpty ||
        !networkSegments.isEmpty ||
        !iBeacons.isEmpty
    }
}
