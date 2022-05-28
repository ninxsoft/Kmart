//
//  ReportType.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation

// swiftlint:disable file_length
// swiftlint:disable:next type_body_length
enum ReportType: String, CaseIterable {
    case buildingsNotLinked = "buildings_not_linked"
    case categoriesNotLinked = "categories_not_linked"
    case departmentsNotLinked = "departments_not_linked"
    case eBooksNoScope = "ebooks_no_scope"
    case iBeaconsNotLinked = "ibeacons_not_linked"
    case macAdvancedSearchesNoCriteria = "mac_advanced_searches_no_criteria"
    case macAdvancedSearchesInvalidCriteria = "mac_advanced_searches_invalid_criteria"
    case macApplicationsNoScope = "mac_applications_no_scope"
    case macConfigurationProfilesNoScope = "mac_configuration_profiles_no_scope"
    case macDevicesDuplicateNames = "mac_devices_duplicate_names"
    case macDevicesDuplicateSerialNumbers = "mac_devices_duplicate_serial_numbers"
    case macDevicesLastCheckIn = "mac_devices_last_check_in"
    case macDevicesLastInventory = "mac_devices_last_inventory"
    case macDevicesUnmanaged = "mac_devices_unmanaged"
    case macDirectoryBindingsNotLinked = "mac_directory_bindings_not_linked"
    case macDiskEncryptionsNotLinked = "mac_disk_encryptions_not_linked"
    case macDockItemsNotLinked = "mac_dock_items_not_linked"
    case macExtensionAttributesNotLinked = "mac_extension_attributes_not_linked"
    case macExtensionAttributesDisabled = "mac_extension_attributes_disabled"
    case macExtensionAttributesLinterErrors = "mac_extension_attributes_linter_errors"
    case macExtensionAttributesLinterWarnings = "mac_extension_attributes_linter_warnings"
    case macPackagesNotLinked = "mac_packages_not_linked"
    case macPatchPoliciesNoScope = "mac_patch_policies_no_scope"
    case macPatchPoliciesDisabled = "mac_patch_policies_disabled"
    case macPoliciesNoScope = "mac_policies_no_scope"
    case macPoliciesDisabled = "mac_policies_disabled"
    case macPoliciesNoPayload = "mac_policies_no_payload"
    case macPoliciesJamfRemote = "mac_policies_jamf_remote"
    case macPoliciesLastExecuted = "mac_policies_last_executed"
    case macPoliciesFailedThreshold = "mac_policies_failed_threshold"
    case macPrintersNotLinked = "mac_printers_not_linked"
    case macRestrictedSoftwareNoScope = "mac_restricted_software_no_scope"
    case macScriptsNotLinked = "mac_scripts_not_linked"
    case macScriptsLinterErrors = "mac_scripts_linter_errors"
    case macScriptsLinterWarnings = "mac_scripts_linter_warnings"
    case macSmartGroupsNotLinked = "mac_smart_groups_not_linked"
    case macSmartGroupsNoCriteria = "mac_smart_groups_no_criteria"
    case macStaticGroupsNotLinked = "mac_static_groups_not_linked"
    case macStaticGroupsEmpty = "mac_static_groups_empty"
    case mobileAdvancedSearchesNoCriteria = "mobile_advanced_searches_no_criteria"
    case mobileAdvancedSearchesInvalidCriteria = "mobile_advanced_searches_invalid_criteria"
    case mobileApplicationsNoScope = "mobile_applications_no_scope"
    case mobileConfigurationProfilesNoScope = "mobile_configuration_profiles_no_scope"
    case mobileDevicesLastInventory = "mobile_devices_last_inventory"
    case mobileDevicesUnmanaged = "mobile_devices_unmanaged"
    case mobileExtensionAttributesNotLinked = "mobile_extension_attributes_not_linked"
    case mobileSmartGroupsNotLinked = "mobile_smart_groups_not_linked"
    case mobileSmartGroupsNoCriteria = "mobile_smart_groups_no_criteria"
    case mobileStaticGroupsNotLinked = "mobile_static_groups_not_linked"
    case mobileStaticGroupsEmpty = "mobile_static_groups_empty"
    case networkSegmentsNotLinked = "network_segments_not_linked"

    var identifier: String {
        self.rawValue
    }

    var endpoints: [Endpoint] {
        switch self {
        case .buildingsNotLinked:
            return [
                .buildings, .networkSegments,
                .macApplications, .macConfigurationProfiles, .macDevices, .macPatchPolicies, .macPolicies, .macRestrictedSoftware,
                .mobileApplications, .mobileConfigurationProfiles, .mobileDevices
            ]
        case .categoriesNotLinked:
            return [
                .categories,
                .macApplications, .macConfigurationProfiles, .macPackages, .macPatchSoftwareTitles, .macPolicies, .macPrinters, .macScripts,
                .mobileApplications, .mobileConfigurationProfiles
            ]
        case .departmentsNotLinked:
            return [
                .departments, .networkSegments,
                .macApplications, .macConfigurationProfiles, .macDevices, .macPatchPolicies, .macPolicies, .macRestrictedSoftware,
                .mobileApplications, .mobileConfigurationProfiles, .mobileDevices
            ]
        case .eBooksNoScope:
            return [.eBooks]
        case .iBeaconsNotLinked:
            return [.iBeacons, .macConfigurationProfiles, .macPatchPolicies, .macPolicies, .mobileConfigurationProfiles]
        case .macAdvancedSearchesNoCriteria:
            return [.macAdvancedSearches]
        case .macAdvancedSearchesInvalidCriteria:
            return [.macAdvancedSearches, .macGroups]
        case .macApplicationsNoScope:
            return [.macApplications]
        case .macConfigurationProfilesNoScope:
            return [.macConfigurationProfiles]
        case .macDevicesDuplicateNames:
            return [.macDevices]
        case .macDevicesDuplicateSerialNumbers:
            return [.macDevices]
        case .macDevicesLastCheckIn:
            return [.macDevices]
        case .macDevicesLastInventory:
            return [.macDevices]
        case .macDevicesUnmanaged:
            return [.macDevices]
        case .macDirectoryBindingsNotLinked:
            return [.macDirectoryBindings, .macPolicies]
        case .macDiskEncryptionsNotLinked:
            return [.macDiskEncryptions, .macPolicies]
        case .macDockItemsNotLinked:
            return [.macDockItems, .macPolicies]
        case .macExtensionAttributesNotLinked:
            return [.macAdvancedSearches, .macExtensionAttributes, .macGroups]
        case .macExtensionAttributesDisabled:
            return [.macExtensionAttributes]
        case .macExtensionAttributesLinterErrors:
            return [.macExtensionAttributes]
        case .macExtensionAttributesLinterWarnings:
            return [.macExtensionAttributes]
        case .macPackagesNotLinked:
            return [.macPackages, .macPatchSoftwareTitles, .macPolicies]
        case .macPatchPoliciesNoScope:
            return [.macPatchPolicies]
        case .macPatchPoliciesDisabled:
            return [.macPatchPolicies]
        case .macPoliciesNoScope:
            return [.macPolicies]
        case .macPoliciesDisabled:
            return [.macPolicies]
        case .macPoliciesJamfRemote:
            return [.macPolicies]
        case .macPoliciesNoPayload:
            return [.macPolicies]
        case .macPoliciesLastExecuted:
            return [.macDevicesHistory, .macPolicies]
        case .macPoliciesFailedThreshold:
            return [.macDevicesHistory, .macPolicies]
        case .macPrintersNotLinked:
            return [.macPolicies, .macPrinters]
        case .macRestrictedSoftwareNoScope:
            return [.macRestrictedSoftware]
        case .macScriptsNotLinked:
            return [.macScripts, .macPolicies]
        case .macScriptsLinterErrors:
            return [.macScripts]
        case .macScriptsLinterWarnings:
            return [.macScripts]
        case .macSmartGroupsNotLinked:
            return [.macAdvancedSearches, .macApplications, .macConfigurationProfiles, .macPatchPolicies, .macPolicies, .macRestrictedSoftware, .macGroups]
        case .macSmartGroupsNoCriteria:
            return [.macGroups]
        case .macStaticGroupsNotLinked:
            return [.macAdvancedSearches, .macApplications, .macConfigurationProfiles, .macPatchPolicies, .macPolicies, .macRestrictedSoftware, .macGroups]
        case .macStaticGroupsEmpty:
            return [.macGroups]
        case .mobileAdvancedSearchesNoCriteria:
            return [.mobileAdvancedSearches]
        case .mobileAdvancedSearchesInvalidCriteria:
            return [.mobileAdvancedSearches, .mobileGroups]
        case .mobileApplicationsNoScope:
            return [.mobileApplications]
        case .mobileConfigurationProfilesNoScope:
            return [.mobileConfigurationProfiles]
        case .mobileDevicesLastInventory:
            return [.mobileDevices]
        case .mobileDevicesUnmanaged:
            return [.mobileDevices]
        case .mobileExtensionAttributesNotLinked:
            return [.mobileAdvancedSearches, .mobileExtensionAttributes, .mobileGroups]
        case .mobileSmartGroupsNotLinked:
            return [.mobileAdvancedSearches, .mobileApplications, .mobileConfigurationProfiles, .mobileGroups]
        case .mobileSmartGroupsNoCriteria:
            return [.mobileGroups]
        case .mobileStaticGroupsNotLinked:
            return [.mobileAdvancedSearches, .mobileApplications, .mobileConfigurationProfiles, .mobileGroups]
        case .mobileStaticGroupsEmpty:
            return [.mobileGroups]
        case .networkSegmentsNotLinked:
            return [
                .buildings, .departments, .eBooks, .networkSegments,
                .macApplications, .macConfigurationProfiles, .macPatchPolicies, .macPolicies,
                .mobileApplications, .mobileConfigurationProfiles
            ]
        }
    }

    var endpoint: Endpoint {
        switch self {
        case .buildingsNotLinked:
            return .buildings
        case .categoriesNotLinked:
            return .categories
        case .departmentsNotLinked:
            return .departments
        case .eBooksNoScope:
            return .eBooks
        case .iBeaconsNotLinked:
            return .iBeacons
        case .macAdvancedSearchesNoCriteria, .macAdvancedSearchesInvalidCriteria:
            return .macAdvancedSearches
        case .macApplicationsNoScope:
            return .macApplications
        case .macConfigurationProfilesNoScope:
            return .macConfigurationProfiles
        case .macDevicesDuplicateNames, .macDevicesDuplicateSerialNumbers, .macDevicesLastCheckIn, .macDevicesLastInventory, .macDevicesUnmanaged:
            return .macDevices
        case .macDirectoryBindingsNotLinked:
            return .macDirectoryBindings
        case .macDiskEncryptionsNotLinked:
            return .macDiskEncryptions
        case .macDockItemsNotLinked:
            return .macDockItems
        case .macExtensionAttributesNotLinked, .macExtensionAttributesDisabled, .macExtensionAttributesLinterErrors, .macExtensionAttributesLinterWarnings:
            return .macExtensionAttributes
        case .macPackagesNotLinked:
            return .macPackages
        case .macPatchPoliciesNoScope, .macPatchPoliciesDisabled:
            return .macPatchPolicies
        case .macPoliciesNoScope, .macPoliciesDisabled, .macPoliciesNoPayload, .macPoliciesJamfRemote, .macPoliciesLastExecuted, .macPoliciesFailedThreshold:
            return .macPolicies
        case .macPrintersNotLinked:
            return .macPrinters
        case .macRestrictedSoftwareNoScope:
            return .macRestrictedSoftware
        case .macScriptsNotLinked, .macScriptsLinterErrors, .macScriptsLinterWarnings:
            return .macScripts
        case .macSmartGroupsNotLinked, .macSmartGroupsNoCriteria, .macStaticGroupsNotLinked, .macStaticGroupsEmpty:
            return .macGroups
        case .mobileAdvancedSearchesNoCriteria, .mobileAdvancedSearchesInvalidCriteria:
            return .mobileAdvancedSearches
        case .mobileApplicationsNoScope:
            return .mobileApplications
        case .mobileConfigurationProfilesNoScope:
            return .mobileConfigurationProfiles
        case .mobileDevicesLastInventory, .mobileDevicesUnmanaged:
            return .mobileDevices
        case .mobileExtensionAttributesNotLinked:
            return .mobileExtensionAttributes
        case .mobileSmartGroupsNotLinked, .mobileSmartGroupsNoCriteria, .mobileStaticGroupsNotLinked, .mobileStaticGroupsEmpty:
            return .mobileGroups
        case .networkSegmentsNotLinked:
            return .networkSegments
        }
    }

    var markdownDescription: String {
        switch self {
        case .buildingsNotLinked:
            return "The following Buildings are not linked to anything"
        case .categoriesNotLinked:
            return "The following Categories are not linked to anything"
        case .departmentsNotLinked:
            return "The following Departments are not linked to anything"
        case .eBooksNoScope:
            return "The following eBooks have no scope"
        case .iBeaconsNotLinked:
            return "The following iBeacons are not linked to anything"
        case .macAdvancedSearchesNoCriteria:
            return "The following Mac Advanced Searches have no criteria"
        case .macAdvancedSearchesInvalidCriteria:
            return "The following Mac Advanced Searches have invalid criteria"
        case .macApplicationsNoScope:
            return "The following Mac Applications have no scope"
        case .macConfigurationProfilesNoScope:
            return "The following Mac Configuration Profiles have no scope"
        case .macDevicesDuplicateNames:
            return "The following Mac Devices have duplicated names"
        case .macDevicesDuplicateSerialNumbers:
            return "The following Mac Devices have duplicated serial numbers"
        case .macDevicesLastCheckIn:
            return "The following Mac Devices have met the last check-in threshold"
        case .macDevicesLastInventory:
            return "The following Mac Devices have met the last inventory threshold"
        case .macDevicesUnmanaged:
            return "The following Mac Devices are unmanaged"
        case .macDirectoryBindingsNotLinked:
            return "The following Mac Directory Bindings are not linked to any Policies"
        case .macDiskEncryptionsNotLinked:
            return "The following Mac Disk Encryptions are not linked to any Policies"
        case .macDockItemsNotLinked:
            return "The following Mac Dock Items are not linked to any Policies"
        case .macExtensionAttributesNotLinked:
            return "The following Mac Extension Attributes are not linked to anything"
        case .macExtensionAttributesDisabled:
            return "The following Mac Extension Attributes are disabled"
        case .macExtensionAttributesLinterErrors:
            return "The following Mac Extension Attributes have linter errors"
        case .macExtensionAttributesLinterWarnings:
            return "The following Mac Extension Attributes have linter warnings"
        case .macPackagesNotLinked:
            return "The following Mac Packages are not linked to any Policies"
        case .macPatchPoliciesNoScope:
            return "The following Mac Patch Policies have no scope"
        case .macPatchPoliciesDisabled:
            return "The following Mac Patch Policies are disabled"
        case .macPoliciesNoScope:
            return "The following Mac Policies have no scope"
        case .macPoliciesDisabled:
            return "The following Mac Policies are disabled"
        case .macPoliciesNoPayload:
            return "The following Mac Policies have no payload"
        case .macPoliciesJamfRemote:
            return "The following Mac Policies were created via Jamf Remote"
        case .macPoliciesLastExecuted:
            return "The following Mac Policies have met the last executed threshold"
        case .macPoliciesFailedThreshold:
            return "The following Mac Policies have met the failed threshold"
        case .macPrintersNotLinked:
            return "The following Mac Printers are not linked to any Policies"
        case .macRestrictedSoftwareNoScope:
            return "The following Mac Restricted Software have no scope"
        case .macScriptsNotLinked:
            return "The following Mac Scripts are not linked to any Policies"
        case .macScriptsLinterErrors:
            return "The following Mac Scripts have linter errors"
        case .macScriptsLinterWarnings:
            return "The following Mac Scripts have linter warnings"
        case .macSmartGroupsNotLinked:
            return "The following Mac Smart Groups are not linked to anything"
        case .macSmartGroupsNoCriteria:
            return "The following Mac Smart Groups have no criteria"
        case .macStaticGroupsNotLinked:
            return "The following Mac Static Groups are not linked to anything"
        case .macStaticGroupsEmpty:
            return "The following Mac Static Groups are empty"
        case .mobileAdvancedSearchesNoCriteria:
            return "The following Mobile Advanced Searches have no criteria"
        case .mobileAdvancedSearchesInvalidCriteria:
            return "The following Mobile Advanced Searches have invalid criteria"
        case .mobileApplicationsNoScope:
            return "The following Mobile Applications have no scope"
        case .mobileConfigurationProfilesNoScope:
            return "The following Mobile Configuration Profiles have no scope"
        case .mobileDevicesLastInventory:
            return "The following Mobile Devices have met the last inventory threshold"
        case .mobileDevicesUnmanaged:
            return "The following Mobile Devices are unmanaged"
        case .mobileExtensionAttributesNotLinked:
            return "The following Mobile Extension Attributes are not linked to anything"
        case .mobileSmartGroupsNotLinked:
            return "The following Mobile Smart Groups are not linked to anything"
        case .mobileSmartGroupsNoCriteria:
            return "The following Mobile Smart Groups have no criteria"
        case .mobileStaticGroupsNotLinked:
            return "The following Mobile Static Groups are not linked to anything"
        case .mobileStaticGroupsEmpty:
            return "The following Mobile Static Groups are empty"
        case .networkSegmentsNotLinked:
            return "The following Network Segments are not linked to anything"
        }
    }

    var jamfProSlug: String {
        switch self {
        case .buildingsNotLinked:
            return "/view/settings/network/buildings/"
        case .categoriesNotLinked:
            return "categories.html?id="
        case .departmentsNotLinked:
            return "/view/settings/network/departments/"
        case .eBooksNoScope:
            return "eBooks.html?id="
        case .iBeaconsNotLinked:
            return "ibeacons.html?id="
        case .macAdvancedSearchesNoCriteria, .macAdvancedSearchesInvalidCriteria:
            return "advancedComputerSearches.html?id="
        case .macApplicationsNoScope:
            return "macApps.html?id="
        case .macConfigurationProfilesNoScope:
            return "OSXConfigurationProfiles.html?id="
        case .macDevicesDuplicateNames, .macDevicesDuplicateSerialNumbers, .macDevicesLastCheckIn, .macDevicesLastInventory, .macDevicesUnmanaged:
            return "computers.html?id="
        case .macDirectoryBindingsNotLinked:
            return "directoryBindings.html?id="
        case .macDiskEncryptionsNotLinked:
            return "diskEncryptions.html?id="
        case .macDockItemsNotLinked:
            return "dockItems.html?id="
        case .macExtensionAttributesNotLinked, .macExtensionAttributesDisabled, .macExtensionAttributesLinterErrors, .macExtensionAttributesLinterWarnings:
            return "computerExtensionAttributes.html?id="
        case .macPackagesNotLinked:
            return "packages.html?id="
        case .macPatchPoliciesNoScope, .macPatchPoliciesDisabled:
            return "patchDeployment.html?id="
        case .macPoliciesNoScope, .macPoliciesDisabled, .macPoliciesNoPayload, .macPoliciesJamfRemote, .macPoliciesLastExecuted, .macPoliciesFailedThreshold:
            return "policies.html?id="
        case .macPrintersNotLinked:
            return "printers.html?id="
        case .macRestrictedSoftwareNoScope:
            return "restrictedSoftware.html?id="
        case .macScriptsNotLinked, .macScriptsLinterErrors, .macScriptsLinterWarnings:
            return "view/settings/computer/scripts/"
        case .macSmartGroupsNotLinked, .macSmartGroupsNoCriteria:
            return "smartComputerGroups.html?id="
        case .macStaticGroupsNotLinked, .macStaticGroupsEmpty:
            return "staticComputerGroups.html?id="
        case .mobileAdvancedSearchesNoCriteria, .mobileAdvancedSearchesInvalidCriteria:
            return "advancedMobileDeviceSearches.html?id="
        case .mobileApplicationsNoScope:
            return "mobileDeviceApps.html?id="
        case .mobileConfigurationProfilesNoScope:
            return "iOSConfigurationProfiles.html?id="
        case .mobileDevicesLastInventory, .mobileDevicesUnmanaged:
            return "/mobileDevices.html?id="
        case .mobileExtensionAttributesNotLinked:
            return "/mobileDeviceExtensionAttributes.html?id="
        case .mobileSmartGroupsNotLinked, .mobileSmartGroupsNoCriteria:
            return "smartMobileDeviceGroups.html?id="
        case .mobileStaticGroupsNotLinked, .mobileStaticGroupsEmpty:
            return "staticMobileDeviceGroups.html?id="
        case .networkSegmentsNotLinked:
            return "/networkSegments.html?id="
        }
    }
}
