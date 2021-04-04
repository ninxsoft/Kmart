//
//  MobileExclusions.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct MobileExclusions: Codable {
    var buildings: [Int] = []
    var departments: [Int] = []
    var devices: [Int] = []
    var deviceGroups: [Int] = []
    var users: [String] = []
    var userGroups: [String] = []
    var jssUsers: [Int] = []
    var jssUserGroups: [Int] = []
    var networkSegments: [Int] = []
    var scope: Bool {
        !buildings.isEmpty ||
        !departments.isEmpty ||
        !devices.isEmpty ||
        !deviceGroups.isEmpty ||
        !users.isEmpty ||
        !userGroups.isEmpty ||
        !jssUsers.isEmpty ||
        !jssUserGroups.isEmpty ||
        !networkSegments.isEmpty
    }
}
