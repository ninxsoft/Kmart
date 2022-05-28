//
//  MacTargets.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation
import SWXMLHash

struct MacTargets: Codable, XMLObjectDeserialization {
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

    static func deserialize(_ node: XMLIndexer) throws -> MacTargets {

        var buildings: [Int] = []
        var departments: [Int] = []
        var devices: [Int] = []
        var deviceGroups: [Int] = []

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

        return try MacTargets(allDevices: node["all_computers"].value(), buildings: buildings, departments: departments, devices: devices, deviceGroups: deviceGroups)
    }
}
