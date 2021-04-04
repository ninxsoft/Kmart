//
//  MobileTargets.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct MobileTargets: Codable {
    var allDevices: Bool = false
    var allUsers: Bool = false
    var buildings: [Int] = []
    var departments: [Int] = []
    var devices: [Int] = []
    var deviceGroups: [Int] = []
    var users: [Int] = []
    var userGroups: [Int] = []
    var scope: Bool {
        allDevices ||
        allUsers ||
        !buildings.isEmpty ||
        !departments.isEmpty ||
        !devices.isEmpty ||
        !deviceGroups.isEmpty ||
        !users.isEmpty ||
        !userGroups.isEmpty
    }
}
