//
//  Dictionary+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

extension Dictionary where Key == String, Value == Any {

    mutating func transform(endpoint: Endpoint) {
        self.transformGeneral(for: endpoint)
        self.transformCriteria(for: endpoint)
        self.transformScopeMacTargets(for: endpoint)
        self.transformScopeMacExclusions(for: endpoint)
        self.transformScopeMobileTargets(for: endpoint)
        self.transformScopeMobileExclusions(for: endpoint)
        self.transformScopeLimitations(for: endpoint)
        self.transformVPP(for: endpoint)
        self.transformLocation(for: endpoint)
        self.transformMacDeviceHistory(for: endpoint)
        self.transformMacExtensionAttributes(for: endpoint)
        self.transformMacPolicies(for: endpoint)
        self.transformMacScripts(for: endpoint)
        self.transformMacStaticGroups(for: endpoint)
        self.transformMobileStaticGroups(for: endpoint)
    }

    private mutating func transformGeneral(for endpoint: Endpoint) {

        guard [
            .eBooks,
            .macApplications,
            .macConfigurationProfiles,
            .macDevices,
            .macPolicies,
            .macRestrictedSoftware,
            .mobileApplications,
            .mobileConfigurationProfiles,
            .mobileDevices,
            .macDevicesHistory
        ].contains(endpoint) else {
            return
        }

        guard let dictionary: [String: Any] = self["general"] as? [String: Any],
            let identifier: Int = dictionary["id"] as? Int,
            let name: String = dictionary["name"] as? String else {
            return
        }

        self["id"] = identifier
        self["name"] = name
        self["category"] = ((dictionary["category"] as? [String: Any])?["id"] as? Int)
        self["enabled"] = dictionary["enabled"] as? Bool ?? false
        self["serialNumber"] = dictionary["serial_number"] ?? ""
        self["lastCheckIn"] = Double(dictionary["last_contact_time_epoch"] as? Int ?? 0) / 1_000

        if let int: Int = dictionary["report_date_epoch"] as? Int {
            self["lastInventory"] = Double(int) / 1_000
        } else if let int: Int = dictionary["last_inventory_update_epoch"] as? Int {
            self["lastInventory"] = Double(int) / 1_000
        }

        if let remoteManagement: [String: Any] = dictionary["remote_management"] as? [String: Any],
            let managed: Bool = remoteManagement["managed"] as? Bool {
            self["managed"] = managed
        } else {
            self["managed"] = false
        }

        self["softwareUpdates"] = ((dictionary["override_default_settings"] as? [String: Any])?["sus"] as? String) != "default"
    }

    private mutating func transformCriteria(for endpoint: Endpoint) {

        guard [.macAdvancedSearches, .macGroups, .mobileAdvancedSearches, .mobileGroups].contains(endpoint) else {
            return
        }

        guard var criteria: [[String: Any]] = self["criteria"] as? [[String: Any]] else {
            return
        }

        for (index, criterion) in criteria.enumerated() {
            if let string: String = criterion["search_type"] as? String {
                criteria[index]["type"] = string
            }
        }

        self["criteria"] = criteria
    }

    private mutating func transformScopeMacTargets(for endpoint: Endpoint) {

        guard [.eBooks, .macApplications, .macConfigurationProfiles, .macPolicies, .macRestrictedSoftware, .mobileApplications, .mobileConfigurationProfiles].contains(endpoint) else {
            return
        }

        guard var targets: [String: Any] = self["scope"] as? [String: Any],
            let allDevices: Bool = targets["all_computers"] as? Bool,
            let buildings: [[String: Any]] = targets["buildings"] as? [[String: Any]],
            let departments: [[String: Any]] = targets["departments"] as? [[String: Any]],
            let devices: [[String: Any]] = targets["computers"] as? [[String: Any]],
            let deviceGroups: [[String: Any]] = targets["computer_groups"] as? [[String: Any]] else {
            return
        }

        targets["allDevices"] = allDevices
        targets["buildings"] = buildings.identifiers
        targets["departments"] = departments.identifiers
        targets["devices"] = devices.identifiers
        targets["deviceGroups"] = deviceGroups.identifiers
        self["macTargets"] = targets
    }

    private mutating func transformScopeMacExclusions(for endpoint: Endpoint) {

        guard [.eBooks, .macApplications, .macConfigurationProfiles, .macPolicies, .macRestrictedSoftware, .mobileApplications, .mobileConfigurationProfiles].contains(endpoint) else {
            return
        }

        guard let dictionary: [String: Any] = self["scope"] as? [String: Any],
            var exclusions: [String: Any] = dictionary["exclusions"] as? [String: Any],
            let buildings: [[String: Any]] = exclusions["buildings"] as? [[String: Any]],
            let departments: [[String: Any]] = exclusions["departments"] as? [[String: Any]],
            let devices: [[String: Any]] = exclusions["computers"] as? [[String: Any]],
            let deviceGroups: [[String: Any]] = exclusions["computer_groups"] as? [[String: Any]],
            let users: [[String: Any]] = exclusions["users"] as? [[String: Any]] else {
            return
        }

        exclusions["buildings"] = buildings.identifiers
        exclusions["departments"] = departments.identifiers
        exclusions["devices"] = devices.identifiers
        exclusions["deviceGroups"] = deviceGroups.identifiers
        exclusions["users"] = users.names
        exclusions["userGroups"] = (exclusions["user_groups"] as? [[String: Any]])?.identifiers ?? []
        exclusions["networkSegments"] = (exclusions["network_segments"] as? [[String: Any]])?.identifiers ?? []
        exclusions["iBeacons"] = (exclusions["ibeacons"] as? [[String: Any]])?.identifiers ?? []
        self["macExclusions"] = exclusions
    }

    private mutating func transformScopeMobileTargets(for endpoint: Endpoint) {

        guard [.eBooks, .mobileApplications, .mobileConfigurationProfiles].contains(endpoint) else {
            return
        }

        guard var targets: [String: Any] = self["scope"] as? [String: Any],
            let allDevices: Bool = targets["all_mobile_devices"] as? Bool,
            let allUsers: Bool = targets["all_jss_users"] as? Bool,
            let buildings: [[String: Any]] = targets["buildings"] as? [[String: Any]],
            let departments: [[String: Any]] = targets["departments"] as? [[String: Any]],
            let devices: [[String: Any]] = targets["mobile_devices"] as? [[String: Any]],
            let deviceGroups: [[String: Any]] = targets["mobile_device_groups"] as? [[String: Any]],
            let users: [[String: Any]] = targets["jss_users"] as? [[String: Any]],
            let userGroups: [[String: Any]] = targets["jss_user_groups"] as? [[String: Any]] else {
            return
        }

        targets["allDevices"] = allDevices
        targets["allUsers"] = allUsers
        targets["buildings"] = buildings.identifiers
        targets["departments"] = departments.identifiers
        targets["devices"] = devices.identifiers
        targets["deviceGroups"] = deviceGroups.identifiers
        targets["users"] = users.identifiers
        targets["userGroups"] = userGroups.identifiers
        self["mobileTargets"] = targets
    }

    private mutating func transformScopeMobileExclusions(for endpoint: Endpoint) {

        guard [.eBooks, .mobileApplications, .mobileConfigurationProfiles].contains(endpoint) else {
            return
        }

        guard let dictionary: [String: Any] = self["scope"] as? [String: Any],
            var exclusions: [String: Any] = dictionary["exclusions"] as? [String: Any],
            let buildings: [[String: Any]] = exclusions["buildings"] as? [[String: Any]],
            let departments: [[String: Any]] = exclusions["departments"] as? [[String: Any]],
            let devices: [[String: Any]] = exclusions["mobile_devices"] as? [[String: Any]],
            let deviceGroups: [[String: Any]] = exclusions["mobile_device_groups"] as? [[String: Any]],
            let users: [[String: Any]] = exclusions["users"] as? [[String: Any]],
            let userGroups: [[String: Any]] = exclusions["user_groups"] as? [[String: String]],
            let jssUsers: [[String: Any]] = exclusions["jss_users"] as? [[String: Any]],
            let jssUserGroups: [[String: Any]] = exclusions["jss_user_groups"] as? [[String: Any]],
            let networkSegments: [[String: Any]] = exclusions["network_segments"] as? [[String: Any]] else {
            return
        }

        exclusions["buildings"] = buildings.identifiers
        exclusions["departments"] = departments.identifiers
        exclusions["devices"] = devices.identifiers
        exclusions["deviceGroups"] = deviceGroups.identifiers
        exclusions["users"] = users.names
        exclusions["userGroups"] = userGroups.identifiers
        exclusions["jssUsers"] = jssUsers.identifiers
        exclusions["jssUserGroups"] = jssUserGroups.identifiers
        exclusions["networkSegments"] = networkSegments.identifiers
        self["mobileExclusions"] = exclusions
    }

    private mutating func transformScopeLimitations(for endpoint: Endpoint) {

        guard [.eBooks, .macApplications, .macConfigurationProfiles, .macPolicies, .mobileApplications, .mobileConfigurationProfiles].contains(endpoint) else {
            return
        }

        guard let dictionary: [String: Any] = self["scope"] as? [String: Any],
            var limitations: [String: Any] = dictionary["limitations"] as? [String: Any],
            let users: [[String: Any]] = limitations["users"] as? [[String: String]],
            let userGroups: [[String: Any]] = limitations["user_groups"] as? [[String: String]],
            let networkSegments: [[String: Any]] = limitations["network_segments"] as? [[String: Any]] else {
            return
        }

        limitations["users"] = users.names
        limitations["userGroups"] = userGroups.identifiers
        limitations["networkSegments"] = networkSegments.identifiers
        limitations["iBeacons"] = (limitations["ibeacons"] as? [[String: Any]])?.identifiers ?? []
        self["limitations"] = limitations
    }

    private mutating func transformVPP(for endpoint: Endpoint) {

        guard [.macApplications, .mobileApplications].contains(endpoint) else {
            return
        }

        guard let dictionary: [String: Any] = self["vpp"] as? [String: Any] else {
            return
        }

        self["vppTotal"] = dictionary["total_vpp_licenses"] as? Int ?? 0
        self["vppUsed"] = dictionary["used_vpp_licenses"] as? Int ?? 0
    }

    private mutating func transformLocation(for endpoint: Endpoint) {

        guard [.macDevices, .mobileDevices].contains(endpoint) else {
            return
        }

        guard let dictionary: [String: Any] = self["location"] as? [String: Any],
            let building: String = dictionary["building"] as? String,
            let department: String = dictionary["department"] as? String else {
            return
        }

        self["building"] = building
        self["department"] = department
    }

    private mutating func transformMacDeviceHistory(for endpoint: Endpoint) {

        guard [.macDevicesHistory].contains(endpoint) else {
            return
        }

        guard var policyLogs: [[String: Any]] = self["policy_logs"] as? [[String: Any]] else {
            return
        }

        for (index, policyLog) in policyLogs.enumerated() {

            guard let identifier: Int = policyLog["policy_id"] as? Int,
                let date: Int = policyLog["date_completed_epoch"] as? Int else {
                continue
            }

            policyLogs[index]["id"] = identifier
            policyLogs[index]["date"] = Double(date) / 1_000
        }

        self["macPolicyLogs"] = policyLogs
    }

    private mutating func transformMacExtensionAttributes(for endpoint: Endpoint) {

        guard [.macExtensionAttributes].contains(endpoint) else {
            return
        }

        guard let dataType: String = self["data_type"] as? String,
            let dictionary: [String: Any] = self["input_type"] as? [String: Any],
            let inputType: String = dictionary["type"] as? String else {
            return
        }

        self["dataType"] = dataType
        self["inputType"] = inputType
        self["scriptContents"] = (dictionary["script"] as? String)?.replacingOccurrences(of: "\r\n", with: "\n") ?? ""
        self["linterWarnings"] = []
        self["linterErrors"] = []
    }

    private mutating func transformMacPolicies(for endpoint: Endpoint) {

        guard [.macPolicies].contains(endpoint) else {
            return
        }

        guard let accountMaintenance: [String: Any] = self["account_maintenance"] as? [String: Any],
            let accounts: [[String: Any]] = accountMaintenance["accounts"] as? [[String: Any]],
            let directoryBindings: [[String: Any]] = accountMaintenance["directory_bindings"] as? [[String: Any]],
            let diskEncryptionDictionary: [String: Any] = self["disk_encryption"] as? [String: Any],
            let dockItems: [[String: Any]] = self["dock_items"] as? [[String: Any]],
            let filesProcesses: [String: Any] = self["files_processes"] as? [String: Any],
            let firmware: [String: Any] = accountMaintenance["open_firmware_efi_password"] as? [String: Any],
            let firmwareString: String = firmware["of_mode"] as? String,
            let managementAccount: [String: Any] = accountMaintenance["management_account"] as? [String: Any],
            let managementAccountString: String = managementAccount["action"] as? String,
            let maintenance: [String: Any] = self["maintenance"] as? [String: Any],
            let packagesDictionary: [String: Any] = self["package_configuration"] as? [String: Any],
            let packages: [[String: Any]] = packagesDictionary["packages"] as? [[String: Any]],
            let printers: [Any] = self["printers"] as? [Any],
            let restart: [String: Any] = self["reboot"] as? [String: Any],
            let restartNoUserLoggedIn: String = restart["no_user_logged_in"] as? String,
            let restartUserLoggedIn: String = restart["user_logged_in"] as? String,
            let scripts: [[String: Any]] = self["scripts"] as? [[String: Any]] else {
            return
        }

        self["accounts"] = !accounts.isEmpty
        self["directoryBindings"] = directoryBindings.identifiers
        self["diskEncryption"] = diskEncryptionDictionary["disk_encryption_configuration_id"] as? Int ?? -1
        self["dockItems"] = dockItems.identifiers
        let filesProcessesKeys: [String] = ["search_by_path", "locate_file", "update_locate_database", "spotlight_search", "search_for_process", "run_command"]
        self["filesProcesses"] = filesProcessesKeys.compactMap { filesProcesses[$0] as? Bool }.contains(true) || filesProcessesKeys.compactMap { filesProcesses[$0] as? String }.contains("")
        self["firmware"] = firmwareString != "none"
        self["managementAccount"] = managementAccountString != "doNotChange"
        let maintenanceKeys: [String] = ["recon", "reset_name", "install_all_cached_packages", "permissions", "byhost", "system_cache", "user_cache", "verify"]
        self["maintenance"] = maintenanceKeys.compactMap { maintenance[$0] as? Bool }.contains(true)
        self["packages"] = packages.identifiers
        self["printers"] = printers.compactMap { $0 as? [String: Any] }.identifiers
        self["restart"] = restartNoUserLoggedIn != "Do not restart" || restartUserLoggedIn != "Do not restart"
        self["scripts"] = scripts.identifiers
    }

    private mutating func transformMacScripts(for endpoint: Endpoint) {

        guard [.macScripts].contains(endpoint) else {
            return
        }

        guard let parameters: [String: String] = self["parameters"] as? [String: String],
            let scriptContents: String = self["script_contents"] as? String else {
            return
        }

        self["parameters"] = parameters.map { $1 }
        self["scriptContents"] = scriptContents
        self["linterWarnings"] = []
        self["linterErrors"] = []
    }

    private mutating func transformMacStaticGroups(for endpoint: Endpoint) {

        guard [.macGroups].contains(endpoint) else {
            return
        }

        guard let devices: [[String: Any]] = self["computers"] as? [[String: Any]] else {
            return
        }

        self["devices"] = devices.identifiers
    }

    private mutating func transformMobileStaticGroups(for endpoint: Endpoint) {

        guard [.mobileGroups].contains(endpoint) else {
            return
        }

        guard let devices: [[String: Any]] = self["mobile_devices"] as? [[String: Any]] else {
            return
        }

        self["devices"] = devices.identifiers
    }
}
