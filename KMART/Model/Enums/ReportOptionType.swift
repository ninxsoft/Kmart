//
//  ReportOptionType.swift
//  KMART
//
//  Created by Nindi Gill on 23/2/21.
//

import Foundation

enum ReportOptionType: String, CaseIterable {
    case macDevicesLastCheckIn = "mac_devices_last_check_in"
    case macDevicesLastInventory = "mac_devices_last_inventory"
    case macPoliciesLastExecuted = "mac_policies_last_executed"
    case macPoliciesFailedThreshold = "mac_policies_failed_threshold"
    case mobileDevicesLastInventory = "mobile_devices_last_inventory"

    var identifier: String {
        self.rawValue
    }
}
