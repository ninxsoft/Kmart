//
//  MobileDevice.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

struct MobileDevice: Codable {
    // swiftlint:disable:next identifier_name
    var id: Int = -1
    var name: String = ""
    var serialNumber: String = ""
    var lastInventory: Double = -1
    var building: String = ""
    var department: String = ""
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name,
            "serial_number": serialNumber
        ]
    }
}
