//
//  MacTargets.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct MacTargets: Codable {
    var allDevices: Bool = false
    var buildings: [Int] = []
    var departments: [Int] = []
    var devices: [Int] = []
    var deviceGroups: [Int] = []
    var scope: Bool {
        allDevices ||
        !buildings.isEmpty ||
        !departments.isEmpty ||
        !devices.isEmpty ||
        !deviceGroups.isEmpty
    }
}
