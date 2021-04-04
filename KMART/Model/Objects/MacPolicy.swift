//
//  MacPolicy.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MacPolicy: Codable {
    // swiftlint:disable:next identifier_name
    var id: Int = -1
    var name: String = ""
    var category: Int = -1
    var enabled: Bool = false
    var macTargets: MacTargets = MacTargets()
    var macExclusions: MacExclusions = MacExclusions()
    var limitations: Limitations = Limitations()
    var directoryBindings: [Int] = []
    var diskEncryption: Int = -1
    var dockItems: [Int] = []
    var packages: [Int] = []
    var printers: [Int] = []
    var scripts: [Int] = []
    var accounts: Bool = false
    var filesProcesses: Bool = false
    var firmware: Bool = false
    var maintenance: Bool = false
    var managementAccount: Bool = false
    var restart: Bool = false
    var softwareUpdates: Bool = false
    var scope: Bool {
        macTargets.scope || macExclusions.scope || limitations.scope
    }
    var payload: Bool {
        diskEncryption != -1 ||
        !directoryBindings.isEmpty ||
        !dockItems.isEmpty ||
        !packages.isEmpty ||
        !printers.isEmpty ||
        !scripts.isEmpty ||
        accounts ||
        filesProcesses ||
        maintenance ||
        managementAccount ||
        restart ||
        softwareUpdates
    }
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name
        ]
    }
}
