//
//  Endpoint.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation

// swiftlint:disable:next type_body_length
enum Endpoint: String {
    case buildings = "buildings"
    case categories = "categories"
    case departments = "departments"
    case eBooks = "ebooks"
    case iBeacons = "ibeacons"
    case macAdvancedSearches = "mac_advanced_searches"
    case macApplications = "mac_applications"
    case macConfigurationProfiles = "mac_configuration_profiles"
    case macDevices = "mac_devices"
    case macDevicesHistory = "mac_devices_history"
    case macDirectoryBindings = "mac_directory_bindings"
    case macDiskEncryptions = "mac_disk_encryptions"
    case macDockItems = "mac_dock_items"
    case macExtensionAttributes = "mac_extension_attributes"
    case macGroups = "mac_groups"
    case macPackages = "mac_packages"
    case macPatchPolicies = "mac_patch_policies"
    case macPatchSoftwareTitles = "mac_patch_software_titles"
    case macPolicies = "mac_policies"
    case macPrinters = "mac_printers"
    case macRestrictedSoftware = "mac_restricted_software"
    case macScripts = "mac_scripts"
    case mobileAdvancedSearches = "mobile_advanced_searches"
    case mobileApplications = "mobile_applications"
    case mobileConfigurationProfiles = "mobile_configuration_profiles"
    case mobileDevices = "mobile_devices"
    case mobileExtensionAttributes = "mobile_extension_attributes"
    case mobileGroups = "mobile_groups"
    case networkSegments = "network_segments"

    var identifier: String {
        self.rawValue
    }

    var fullDescription: String {
        switch self {
        case .buildings:
            return "Buildings"
        case .categories:
            return "Categories"
        case .departments:
            return "Departments"
        case .eBooks:
            return "eBooks"
        case .iBeacons:
            return "iBeacons"
        case .macAdvancedSearches:
            return "Mac Advanced Searches"
        case .macApplications:
            return "Mac Applications"
        case .macConfigurationProfiles:
            return "Mac Configuration Profiles"
        case .macDevices:
            return "Mac Devices"
        case .macDevicesHistory:
            return "Mac Devices History"
        case .macDirectoryBindings:
            return "Mac Directory Bindings"
        case .macDiskEncryptions:
            return "Mac Disk Encryptions"
        case .macDockItems:
            return "Mac Dock Items"
        case .macExtensionAttributes:
            return "Mac Extension Attributes"
        case .macGroups:
            return "Mac Groups"
        case .macPackages:
            return "Mac Packages"
        case .macPatchPolicies:
            return "Mac Patch Policies"
        case .macPatchSoftwareTitles:
            return "Mac Patch Software Titles"
        case .macPolicies:
            return "Mac Policies"
        case .macPrinters:
            return "Mac Printers"
        case .macRestrictedSoftware:
            return "Mac Restricted Software"
        case .macScripts:
            return "Mac Scripts"
        case .mobileAdvancedSearches:
            return "Mobile Advanced Searches"
        case .mobileApplications:
            return "Mobile Applications"
        case .mobileConfigurationProfiles:
            return "Mobile Configuration Profiles"
        case .mobileDevices:
            return "Mobile Devices"
        case .mobileExtensionAttributes:
            return "Mobile Extension Attributes"
        case .mobileGroups:
            return "Mobile Groups"
        case .networkSegments:
            return "Network Segments"
        }
    }

    var description: String {
        switch self {
        case .buildings:
            return "Building"
        case .categories:
            return "Category"
        case .departments:
            return "Department"
        case .eBooks:
            return "eBook"
        case .iBeacons:
            return "iBeacon"
        case .macAdvancedSearches:
            return "Mac Advanced Search"
        case .macApplications:
            return "Mac Application"
        case .macConfigurationProfiles:
            return "Mac Configuration Profile"
        case .macDevices:
            return "Mac Device"
        case .macDevicesHistory:
            return "Mac Device History"
        case .macDirectoryBindings:
            return "Mac Directory Binding"
        case .macDiskEncryptions:
            return "Mac Disk Encryption"
        case .macDockItems:
            return "Mac Dock Item"
        case .macExtensionAttributes:
            return "Mac Extension Attribute"
        case .macGroups:
            return "Mac Group"
        case .macPackages:
            return "Mac Package"
        case .macPatchPolicies:
            return "Mac Patch Policy"
        case .macPatchSoftwareTitles:
            return "Mac Patch Software Title"
        case .macPolicies:
            return "Mac Policy"
        case .macPrinters:
            return "Mac Printer"
        case .macRestrictedSoftware:
            return "Mac Restricted Software"
        case .macScripts:
            return "Mac Script"
        case .mobileAdvancedSearches:
            return "Mobile Advanced Search"
        case .mobileApplications:
            return "Mobile Application"
        case .mobileConfigurationProfiles:
            return "Mobile Configuration Profile"
        case .mobileDevices:
            return "Mobile Device"
        case .mobileExtensionAttributes:
            return "Mobile Extension Attribute"
        case .mobileGroups:
            return "Mobile Group"
        case .networkSegments:
            return "Network Segment"
        }
    }

    var apiSlug: String {
        switch self {
        case .buildings:
            return "buildings"
        case .categories:
            return "categories"
        case .departments:
            return "departments"
        case .eBooks:
            return "ebooks"
        case .iBeacons:
            return "ibeacons"
        case .macAdvancedSearches:
            return "advancedcomputersearches"
        case .macApplications:
            return "macapplications"
        case .macConfigurationProfiles:
            return "osxconfigurationprofiles"
        case .macDevices:
            return "computers"
        case .macDevicesHistory:
            return "computerhistory"
        case .macDirectoryBindings:
            return "directorybindings"
        case .macDiskEncryptions:
            return "diskencryptionconfigurations"
        case .macDockItems:
            return "dockitems"
        case .macExtensionAttributes:
            return "computerextensionattributes"
        case .macGroups:
            return "computergroups"
        case .macPackages:
            return "packages"
        case .macPatchPolicies:
            return "patchpolicies"
        case .macPatchSoftwareTitles:
            return "patchsoftwaretitles"
        case .macPolicies:
            return "policies"
        case .macPrinters:
            return "printers"
        case .macRestrictedSoftware:
            return "restrictedsoftware"
        case .macScripts:
            return "scripts"
        case .mobileAdvancedSearches:
            return "advancedmobiledevicesearches"
        case .mobileApplications:
            return "mobiledeviceapplications"
        case .mobileConfigurationProfiles:
            return "mobiledeviceconfigurationprofiles"
        case .mobileDevices:
            return "mobiledevices"
        case .mobileExtensionAttributes:
            return "mobiledeviceextensionattributes"
        case .mobileGroups:
            return "mobiledevicegroups"
        case .networkSegments:
            return "networksegments"
        }
    }

    var primaryKey: String {
        switch self {
        case .buildings:
            return "buildings"
        case .categories:
            return "categories"
        case .departments:
            return "departments"
        case .eBooks:
            return "ebooks"
        case .iBeacons:
            return "ibeacons"
        case .macAdvancedSearches:
            return "advanced_computer_searches"
        case .macApplications:
            return "mac_applications"
        case .macConfigurationProfiles:
            return "os_x_configuration_profiles"
        case .macDevices:
            return "computers"
        case .macDevicesHistory:
            return "computers"
        case .macDirectoryBindings:
            return "directory_bindings"
        case .macDiskEncryptions:
            return "disk_encryption_configurations"
        case .macDockItems:
            return "dock_items"
        case .macExtensionAttributes:
            return "computer_extension_attributes"
        case .macGroups:
            return "computer_groups"
        case .macPackages:
            return "packages"
        case .macPatchPolicies:
            return "patch_policies"
        case .macPatchSoftwareTitles:
            return "patch_software_titles"
        case .macPolicies:
            return "policies"
        case .macPrinters:
            return "printers"
        case .macRestrictedSoftware:
            return "restricted_software"
        case .macScripts:
            return "scripts"
        case .mobileAdvancedSearches:
            return "advanced_mobile_device_searches"
        case .mobileApplications:
            return "mobile_device_applications"
        case .mobileConfigurationProfiles:
            return "configuration_profiles"
        case .mobileDevices:
            return "mobile_devices"
        case .mobileExtensionAttributes:
            return "mobile_device_extension_attributes"
        case .mobileGroups:
            return "mobile_device_groups"
        case .networkSegments:
            return "network_segments"
        }
    }

    var secondaryKey: String {
        switch self {
        case .buildings:
            return "building"
        case .categories:
            return "category"
        case .departments:
            return "department"
        case .eBooks:
            return "ebook"
        case .iBeacons:
            return "ibeacon"
        case .macAdvancedSearches:
            return "advanced_computer_search"
        case .macApplications:
            return "mac_application"
        case .macConfigurationProfiles:
            return "os_x_configuration_profile"
        case .macDevices:
            return "computer"
        case .macDevicesHistory:
            return "computer_history"
        case .macDirectoryBindings:
            return "directory_binding"
        case .macDiskEncryptions:
            return "disk_encryption_configuration"
        case .macDockItems:
            return "dock_item"
        case .macExtensionAttributes:
            return "computer_extension_attribute"
        case .macGroups:
            return "computer_group"
        case .macPackages:
            return "package"
        case .macPatchPolicies:
            return "patch_policy"
        case .macPatchSoftwareTitles:
            return "patch_software_title"
        case .macPolicies:
            return "policy"
        case .macPrinters:
            return "printer"
        case .macRestrictedSoftware:
            return "restricted_software"
        case .macScripts:
            return "script"
        case .mobileAdvancedSearches:
            return "advanced_mobile_device_search"
        case .mobileApplications:
            return "mobile_device_application"
        case .mobileConfigurationProfiles:
            return "configuration_profile"
        case .mobileDevices:
            return "mobile_device"
        case .mobileExtensionAttributes:
            return "mobile_device_extension_attribute"
        case .mobileGroups:
            return "mobile_device_group"
        case .networkSegments:
            return "network_segment"
        }
    }

    var subset: String {
        switch self {
        case .eBooks, .macConfigurationProfiles, .macPatchPolicies, .mobileConfigurationProfiles:
            return "/subset/general&scope"
        case .macDevices, .mobileDevices:
            return "/subset/general&location"
        case .macDevicesHistory:
            return "/subset/general&policy_logs"
        default:
            return ""
        }
    }

    var markdownIdentifier: String {
        self.rawValue.replacingOccurrences(of: "_", with: "-")
    }

    var requestJSON: Bool {
        ![.macPatchPolicies, .macPatchSoftwareTitles].contains(self)
    }

    func primaryURL(url baseURL: String) -> URL? {
        let string: String = "\(baseURL)/JSSResource/\(self == .macDevicesHistory ? "computers" : self.apiSlug)"
        return URL(string: string)
    }

    func secondaryURL(url baseURL: String, identifier: Int) -> URL? {
        let string: String = "\(baseURL)/JSSResource/\(self.apiSlug)/id/\(identifier)\(self.subset)"
        return URL(string: string)
    }
}
