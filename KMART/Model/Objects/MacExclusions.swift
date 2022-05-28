//
//  MacExclusions.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation
import SWXMLHash

struct MacExclusions: Codable, XMLObjectDeserialization {
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

    // swiftlint:disable:next cyclomatic_complexity
    static func deserialize(_ node: XMLIndexer) throws -> MacExclusions {

        var buildings: [Int] = []
        var departments: [Int] = []
        var devices: [Int] = []
        var deviceGroups: [Int] = []
        var networkSegments: [Int] = []
        var iBeacons: [Int] = []

        for element in node["buildings"].all {

            guard let child = element["building"]["id"].element,
                let building: Int = Int(child.text) else {
                continue
            }

            buildings.append(building)
        }

        for element in node["departments"].all {

            guard let child = element["department"]["id"].element,
                let department: Int = Int(child.text) else {
                continue
            }

            departments.append(department)
        }

        for element in node["computers"].all {

            guard let child = element["computer"]["id"].element,
                let device: Int = Int(child.text) else {
                continue
            }

            devices.append(device)
        }

        for element in node["computer_groups"].all {

            guard let child = element["computer_group"]["id"].element,
                let deviceGroup: Int = Int(child.text) else {
                continue
            }

            deviceGroups.append(deviceGroup)
        }

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

        return MacExclusions(buildings: buildings, departments: departments, devices: devices, deviceGroups: deviceGroups, networkSegments: networkSegments, iBeacons: iBeacons)
    }
}
