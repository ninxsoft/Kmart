//
//  Reporter.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length

/// Struct used to perform all **Reporter** operations.
struct Reporter {

    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length

    /// Generate a reports object from the provided `objects` and `configuration`.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    ///   - configuration: The configuration used to generate the report data.
    /// - Returns: A `reports` object.
    static func generateReports(from objects: Objects, using configuration: Configuration) -> Reports {
        var reports: Reports = Reports()

        for report in configuration.reports {
            let start: Date = Date()
            let startString: String = "Generating report \(report.identifier)..."
            PrettyPrint.print(startString, terminator: "")

            switch report {
            case .buildingsNotLinked:
                reports.buildingsNotLinked.append(contentsOf: buildingsNotLinked(objects))
            case .categoriesNotLinked:
                reports.categoriesNotLinked.append(contentsOf: categoriesNotLinked(objects))
            case .departmentsNotLinked:
                reports.departmentsNotLinked.append(contentsOf: departmentsNotLinked(objects))
            case .eBooksNoScope:
                reports.eBooksNoScope.append(contentsOf: eBooksNoScope(objects.eBooks))
            case .iBeaconsNotLinked:
                reports.iBeaconsNotLinked.append(contentsOf: iBeaconsNotLinked(objects))
            case .networkSegmentsNotLinked:
                reports.networkSegmentsNotLinked.append(contentsOf: networkSegmentsNotLinked(objects))
            case .macAdvancedSearchesNoCriteria:
                reports.macAdvancedSearchesNoCriteria.append(contentsOf: macAdvancedSearchesNoCriteria(objects.macAdvancedSearches))
            case .macAdvancedSearchesInvalidCriteria:
                reports.macAdvancedSearchesInvalidCriteria.append(contentsOf: macAdvancedSearchesInvalidCriteria(objects))
            case .macApplicationsNoScope:
                reports.macApplicationsNoScope.append(contentsOf: macApplicationsNoScope(objects.macApplications))
            case .macConfigurationProfilesNoScope:
                reports.macConfigurationProfilesNoScope.append(contentsOf: macConfigurationProfilesNoScope(objects.macConfigurationProfiles))
            case .macDevicesDuplicateNames:
                reports.macDevicesDuplicateNames.append(contentsOf: macDevicesDuplicateNames(objects.macDevices))
            case .macDevicesDuplicateSerialNumbers:
                reports.macDevicesDuplicateSerialNumbers.append(contentsOf: macDevicesDuplicateSerialNumbers(objects.macDevices))
            case .macDevicesLastCheckIn:
                reports.macDevicesLastCheckIn.append(contentsOf: macDevicesLastCheckIn(objects.macDevices, options: configuration.reportOptions))
            case .macDevicesLastInventory:
                reports.macDevicesLastInventory.append(contentsOf: macDevicesLastInventory(objects.macDevices, options: configuration.reportOptions))
            case .macDevicesUnmanaged:
                reports.macDevicesUnmanaged.append(contentsOf: macDevicesUnmanaged(objects.macDevices))
            case .macDirectoryBindingsNotLinked:
                reports.macDirectoryBindingsNotLinked.append(contentsOf: macDirectoryBindingsNotLinked(objects))
            case .macDiskEncryptionsNotLinked:
                reports.macDiskEncryptionsNotLinked.append(contentsOf: macDiskEncryptionsNotLinked(objects))
            case .macDockItemsNotLinked:
                reports.macDockItemsNotLinked.append(contentsOf: macDockItemsNotLinked(objects))
            case .macExtensionAttributesNotLinked:
                reports.macExtensionAttributesNotLinked.append(contentsOf: macExtensionAttributesNotLinked(objects))
            case .macExtensionAttributesDisabled:
                reports.macExtensionAttributesDisabled.append(contentsOf: macExtensionAttributesDisabled(objects.macExtensionAttributes))
            case .macExtensionAttributesLinterErrors:
                reports.macExtensionAttributesLinterErrors.append(contentsOf: macExtensionAttributesLinterErrors(objects.macExtensionAttributes))
            case .macExtensionAttributesLinterWarnings:
                reports.macExtensionAttributesLinterWarnings.append(contentsOf: macExtensionAttributesLinterWarnings(objects.macExtensionAttributes))
            case .macPackagesNotLinked:
                reports.macPackagesNotLinked.append(contentsOf: macPackagesNotLinked(objects))
            case .macPoliciesNoScope:
                reports.macPoliciesNoScope.append(contentsOf: macPoliciesNoScope(objects.macPolicies))
            case .macPoliciesDisabled:
                reports.macPoliciesDisabled.append(contentsOf: macPoliciesDisabled(objects.macPolicies))
            case .macPoliciesNoPayload:
                reports.macPoliciesNoPayload.append(contentsOf: macPoliciesNoPayload(objects.macPolicies))
            case .macPoliciesJamfRemote:
                reports.macPoliciesJamfRemote.append(contentsOf: macPoliciesJamfRemote(objects.macPolicies))
            case .macPoliciesLastExecuted:
                reports.macPoliciesLastExecuted.append(contentsOf: macPoliciesLastExecuted(objects, options: configuration.reportOptions))
            case .macPoliciesFailedThreshold:
                reports.macPoliciesFailedThreshold.append(contentsOf: macPoliciesFailedThreshold(objects, options: configuration.reportOptions))
            case .macPrintersNotLinked:
                reports.macPrintersNotLinked.append(contentsOf: macPrintersNotLinked(objects))
            case .macRestrictedSoftwareNoScope:
                reports.macRestrictedSoftwaresNoScope.append(contentsOf: macRestrictedSoftwaresNoScope(objects.macRestrictedSoftwares))
            case .macScriptsNotLinked:
                reports.macScriptsNotLinked.append(contentsOf: macScriptsNotLinked(objects))
            case .macScriptsLinterErrors:
                reports.macScriptsLinterErrors.append(contentsOf: macScriptsLinterErrors(objects.macScripts))
            case .macScriptsLinterWarnings:
                reports.macScriptsLinterWarnings.append(contentsOf: macScriptsLinterWarnings(objects.macScripts))
            case .macSmartGroupsNotLinked:
                reports.macSmartGroupsNotLinked.append(contentsOf: macSmartGroupsNotLinked(objects))
            case .macSmartGroupsNoCriteria:
                reports.macSmartGroupsNoCriteria.append(contentsOf: macSmartGroupsNoCriteria(objects.macSmartGroups))
            case .macStaticGroupsNotLinked:
                reports.macStaticGroupsNotLinked.append(contentsOf: macStaticGroupsNotLinked(objects))
            case .macStaticGroupsEmpty:
                reports.macStaticGroupsEmpty.append(contentsOf: macStaticGroupsEmpty(objects.macStaticGroups))
            case .mobileAdvancedSearchesNoCriteria:
                reports.mobileAdvancedSearchesNoCriteria.append(contentsOf: mobileAdvancedSearchesNoCriteria(mobileAdvancedSearchesNoCriteria(objects.mobileAdvancedSearches)))
            case .mobileAdvancedSearchesInvalidCriteria:
                reports.mobileAdvancedSearchesInvalidCriteria.append(contentsOf: mobileAdvancedSearchesInvalidCriteria(objects))
            case .mobileApplicationsNoScope:
                reports.mobileApplicationsNoScope.append(contentsOf: mobileApplicationsNoScope(objects.mobileApplications))
            case .mobileConfigurationProfilesNoScope:
                reports.mobileConfigurationProfilesNoScope.append(contentsOf: mobileConfigurationProfilesNoScope(objects.mobileConfigurationProfiles))
            case .mobileDevicesLastInventory:
                reports.mobileDevicesLastInventory.append(contentsOf: mobileDevicesLastInventory(objects.mobileDevices, options: configuration.reportOptions))
            case .mobileDevicesUnmanaged:
                reports.mobileDevicesUnmanaged.append(contentsOf: mobileDevicesUnmanaged(objects.mobileDevices))
            case .mobileExtensionAttributesNotLinked:
                reports.mobileExtensionAttributesNotLinked.append(contentsOf: mobileExtensionAttributesNotLinked(objects))
            case .mobileSmartGroupsNotLinked:
                reports.mobileSmartGroupsNotLinked.append(contentsOf: mobileSmartGroupsNotLinked(objects))
            case .mobileSmartGroupsNoCriteria:
                reports.mobileSmartGroupsNoCriteria.append(contentsOf: mobileSmartGroupsNoCriteria(objects.mobileSmartGroups))
            case .mobileStaticGroupsNotLinked:
                reports.mobileStaticGroupsNotLinked.append(contentsOf: mobileStaticGroupsNotLinked(objects))
            case .mobileStaticGroupsEmpty:
                reports.mobileStaticGroupsEmpty.append(contentsOf: mobileStaticGroupsEmpty(objects.mobileStaticGroups))
            }

            let end: Date = Date()
            let delta: TimeInterval = end.timeIntervalSince(start)
            let endString: String = String(format: " %.1f seconds", delta)
            PrettyPrint.print(endString, prefix: "")
        }

        return reports
    }

    // swiftlint:enable cyclomatic_complexity
    // swiftlint:enable function_body_length

    /// Returns an array of `Buildings` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Buildings` that are not linked.
    static func buildingsNotLinked(_ objects: Objects) -> [Building] {

        var identifiers: [Int] = []

        for networkSegment in objects.networkSegments {
            identifiers.append(contentsOf: objects.buildings.filter { $0.name == networkSegment.building }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macTargets.buildings })
        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macExclusions.buildings })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macTargets.buildings })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macExclusions.buildings })

        for macDevice in objects.macDevices {
            identifiers.append(contentsOf: objects.buildings.filter { $0.name == macDevice.building }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macTargets.buildings })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macExclusions.buildings })
        identifiers.append(contentsOf: objects.macRestrictedSoftwares.flatMap { $0.macTargets.buildings })
        identifiers.append(contentsOf: objects.macRestrictedSoftwares.flatMap { $0.macExclusions.buildings })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileTargets.buildings })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileExclusions.buildings })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileTargets.buildings })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileExclusions.buildings })

        for mobileDevice in objects.mobileDevices {
            identifiers.append(contentsOf: objects.buildings.filter { $0.name == mobileDevice.building }.map { $0.id })
        }

        let buildings: [Building] = objects.buildings.filter { !identifiers.contains($0.id) }
        return buildings
    }

    /// Returns an array of `Categories` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Categories` that are not linked.
    static func categoriesNotLinked(_ objects: Objects) -> [Category] {

        var identifiers: [Int] = []

        identifiers.append(contentsOf: objects.macApplications.map { $0.category })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.map { $0.category })

        for macPackage in objects.macPackages {
            identifiers.append(contentsOf: objects.categories.filter { $0.name == macPackage.category }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.macPolicies.map { $0.category })

        for macPrinter in objects.macPrinters {
            identifiers.append(contentsOf: objects.categories.filter { $0.name == macPrinter.category }.map { $0.id })
        }

        for macScript in objects.macScripts {
            identifiers.append(contentsOf: objects.categories.filter { $0.name == macScript.category }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.mobileApplications.map { $0.category })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.map { $0.category })

        let categories: [Category] = objects.categories.filter { !identifiers.contains($0.id) }
        return categories
    }

    /// Returns an array of `Departments` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Departments` that are not linked.
    static func departmentsNotLinked(_ objects: Objects) -> [Department] {

        var identifiers: [Int] = []
        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macTargets.departments })
        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macExclusions.departments })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macTargets.departments })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macExclusions.departments })

        for macDevice in objects.macDevices {
            identifiers.append(contentsOf: objects.departments.filter { $0.name == macDevice.department }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macTargets.departments })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macExclusions.departments })
        identifiers.append(contentsOf: objects.macRestrictedSoftwares.flatMap { $0.macTargets.departments })
        identifiers.append(contentsOf: objects.macRestrictedSoftwares.flatMap { $0.macExclusions.departments })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileTargets.departments })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileExclusions.departments })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileTargets.departments })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileExclusions.departments })

        for mobileDevice in objects.mobileDevices {
            identifiers.append(contentsOf: objects.departments.filter { $0.name == mobileDevice.department }.map { $0.id })
        }

        for networkSegment in objects.networkSegments {
            identifiers.append(contentsOf: objects.departments.filter { $0.name == networkSegment.department }.map { $0.id })
        }

        let departments: [Department] = objects.departments.filter { !identifiers.contains($0.id) }
        return departments
    }

    /// Returns an array of `eBooks` with no scope.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `eBooks` with no scope.
    static func eBooksNoScope(_ eBooks: [EBook]) -> [EBook] {
        eBooks.filter { !$0.scope }
    }

    /// Returns an array of `iBeacons` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `iBeacons` that are not linked.
    static func iBeaconsNotLinked(_ objects: Objects) -> [IBeacon] {
        var identifiers: [Int] = []
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macExclusions.iBeacons })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.limitations.iBeacons })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macExclusions.iBeacons })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.limitations.iBeacons })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.limitations.iBeacons })
        let iBeacons: [IBeacon] = objects.iBeacons.filter { !identifiers.contains($0.id) }
        return iBeacons
    }

    /// Returns an array of `Network Segments` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Network Segments` that are not linked.
    static func networkSegmentsNotLinked(_ objects: Objects) -> [NetworkSegment] {
        var identifiers: [Int] = []
        let buildingNames: [String] = objects.buildings.map { $0.name }
        let departmentNames: [String] = objects.departments.map { $0.name }
        identifiers.append(contentsOf: objects.networkSegments.filter { buildingNames.contains($0.building) }.map { $0.id })
        identifiers.append(contentsOf: objects.networkSegments.filter { departmentNames.contains($0.department) }.map { $0.id })
        identifiers.append(contentsOf: objects.eBooks.flatMap { $0.macExclusions.networkSegments })
        identifiers.append(contentsOf: objects.eBooks.flatMap { $0.limitations.networkSegments })
        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macExclusions.networkSegments })
        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.limitations.networkSegments })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macExclusions.networkSegments })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.limitations.networkSegments })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macExclusions.networkSegments })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.limitations.networkSegments })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileExclusions.networkSegments })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.limitations.networkSegments })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileExclusions.networkSegments })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.limitations.networkSegments })
        let networkSegments: [NetworkSegment] = objects.networkSegments.filter { !identifiers.contains($0.id) }
        return networkSegments
    }

    /// Returns an array of `Mac Advanced Searches` with no critiera.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Advanced Searches` with no criteria.
    static func macAdvancedSearchesNoCriteria(_ macAdvancedSearches: [MacAdvancedSearch]) -> [MacAdvancedSearch] {
        macAdvancedSearches.filter { $0.criteria.isEmpty }
    }

    /// Returns an array of `Mac Advanced Searches` with invalid criteria.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Advanced Searches` with invalid criteria.
    static func macAdvancedSearchesInvalidCriteria(_ objects: Objects) -> [MacAdvancedSearch] {
        var identifiers: [Int] = []
        let names: [String] = objects.macSmartGroups.map { $0.name } + objects.macStaticGroups.map { $0.name }

        for macAdvancedSearch in objects.macAdvancedSearches {
            for criterion in macAdvancedSearch.criteria where criterion.name == "Computer Group" && !names.contains(criterion.value) {
                identifiers.append(macAdvancedSearch.id)
            }
        }

        let macAdvancedSearches: [MacAdvancedSearch] = objects.macAdvancedSearches.filter { identifiers.contains($0.id) }
        return macAdvancedSearches
    }

    /// Returns an array of `Mac Applications` with no scope.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Applications` with no scope.
    static func macApplicationsNoScope(_ macApplications: [MacApplication]) -> [MacApplication] {
        macApplications.filter { !$0.scope }
    }

    /// Returns an array of `Mac Configuration Profiles` with no scope.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Configuration Profiles` with no scope.
    static func macConfigurationProfilesNoScope(_ macConfigurationProfiles: [MacConfigurationProfile]) -> [MacConfigurationProfile] {
        macConfigurationProfiles.filter { !$0.scope }
    }

    /// Returns an array of `Mac Devices` with duplicate names.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Devices` with duplicate names.
    static func macDevicesDuplicateNames(_ macDevices: [MacDevice]) -> [MacDevice] {
        let identifiers: [Int] = Dictionary(grouping: macDevices) { $0.name }.filter { $1.count == 1 }.flatMap { $1 }.map { $0.id }
        return macDevices.filter { !identifiers.contains($0.id) }.sorted { $0.name < $1.name }
    }

    /// Returns an array of `Mac Devices` with duplicate serial numbers.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Devices` with duplicate serial numbers.
    static func macDevicesDuplicateSerialNumbers(_ macDevices: [MacDevice]) -> [MacDevice] {
        let identifiers: [Int] = Dictionary(grouping: macDevices) { $0.serialNumber }.filter { $1.count == 1 }.flatMap { $1 }.map { $0.id }
        return macDevices.filter { !identifiers.contains($0.id) }.sorted { $0.serialNumber < $1.serialNumber }
    }

    /// Returns an array of `Mac Devices` that have not checked in since the **Last Check-In** threshold.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Devices` that have not checked in since the **Last Check-In** threshold.
    static func macDevicesLastCheckIn(_ macDevices: [MacDevice], options: [ReportOptionType: Int]) -> [MacDevice] {
        let lastCheckIn: Int = options[.macDevicesLastCheckIn] ?? .defaultOption
        let now: Date = Date()
        return macDevices.filter { $0.lastCheckIn.daysSince(now) >= lastCheckIn && $0.managed }
    }

    /// Returns an array of `Mac Devices` that have not updated inventory since the **Last Inventory** threshold.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Devices` that have not updated inventory since the **Last Inventory** threshold.
    static func macDevicesLastInventory(_ macDevices: [MacDevice], options: [ReportOptionType: Int]) -> [MacDevice] {
        let lastInventory: Int = options[.macDevicesLastInventory] ?? .defaultOption
        let now: Date = Date()
        return macDevices.filter { $0.lastInventory.daysSince(now) >= lastInventory && $0.managed }
    }

    /// Returns an array of `Mac Devices` that are unmanaged.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Devices` that are unmanaged.
    static func macDevicesUnmanaged(_ macDevices: [MacDevice]) -> [MacDevice] {
        macDevices.filter { !$0.managed }
    }

    /// Returns an array of `Mac Directory Bindings` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Directory Bindings` that are not linked.
    static func macDirectoryBindingsNotLinked(_ objects: Objects) -> [MacDirectoryBinding] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.directoryBindings }
        let macDirectoryBindings: [MacDirectoryBinding] = objects.macDirectoryBindings.filter { !identifiers.contains($0.id) }
        return macDirectoryBindings
    }

    /// Returns an array of `Mac Disk Encryptions` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Disk Encryptions` that are not linked.
    static func macDiskEncryptionsNotLinked(_ objects: Objects) -> [MacDiskEncryption] {
        let identifiers: [Int] = objects.macPolicies.map { $0.diskEncryption }
        let macDiskEncryptions: [MacDiskEncryption] = objects.macDiskEncryptions.filter { !identifiers.contains($0.id) }
        return macDiskEncryptions
    }

    /// Returns an array of `Mac Dock Items` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Dock Items` that are not linked.
    static func macDockItemsNotLinked(_ objects: Objects) -> [MacDockItem] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.dockItems }
        let macDockItems: [MacDockItem] = objects.macDockItems.filter { !identifiers.contains($0.id) }
        return macDockItems
    }

    /// Returns an array of `Mac Extension Attributes` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Extension Attributes` that are not linked.
    static func macExtensionAttributesNotLinked(_ objects: Objects) -> [MacExtensionAttribute] {

        var names: [String] = []
        let macExtensionAttributeNames: [String] = objects.macExtensionAttributes.map { $0.name }

        for macAdvancedSearch in objects.macAdvancedSearches {
            names.append(contentsOf: macAdvancedSearch.criteria.filter { macExtensionAttributeNames.contains($0.name) }.map { $0.name })
        }

        for macSmartGroup in objects.macSmartGroups {
            names.append(contentsOf: macSmartGroup.criteria.filter { macExtensionAttributeNames.contains($0.name) }.map { $0.name })
        }

        let macExtensionAttributes: [MacExtensionAttribute] = objects.macExtensionAttributes.filter { !names.contains($0.name) }
        return macExtensionAttributes
    }

    /// Returns an array of `Mac Extension Attributes` that are disabled.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Extension Attributes` that are disabled.
    static func macExtensionAttributesDisabled(_ macExtensionAttributes: [MacExtensionAttribute]) -> [MacExtensionAttribute] {
        macExtensionAttributes.filter { $0.inputType == "Script" && !$0.enabled }
    }

    /// Returns an array of `Mac Extension Attributes` with linter errors.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Extension Attributes` with linter errors.
    static func macExtensionAttributesLinterErrors(_ macExtensionAttributes: [MacExtensionAttribute]) -> [MacExtensionAttribute] {
        macExtensionAttributesLint(macExtensionAttributes, level: .lintError)
    }

    /// Returns an array of `Mac Extension Attributes` with linter warnings.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Extension Attributes` with linter warnings.
    static func macExtensionAttributesLinterWarnings(_ macExtensionAttributes: [MacExtensionAttribute]) -> [MacExtensionAttribute] {
        macExtensionAttributesLint(macExtensionAttributes, level: .lintWarning)
    }

    /// Helper function to perform `Mac Extension Attributes` linting operations.
    ///
    /// - Parameters:
    ///   - macExtensionAttributes: The Mac Extension Attributes to filter.
    ///   - level: The linting level (ie. `.lintError` or `.lintWarning`).
    /// - Returns: An array of `Mac Extension Attributes` with linter errors or warnings.
    static func macExtensionAttributesLint(_ macExtensionAttributes: [MacExtensionAttribute], level: LintLevel) -> [MacExtensionAttribute] {

        guard FileManager.default.fileExists(atPath: "/usr/local/bin/shellcheck") else {
            PrettyPrint.print("shellcheck is not installed, please visit https://github.com/koalaman/shellcheck")
            return []
        }

        guard FileManager.default.fileExists(atPath: "/usr/local/bin/flake8") else {
            PrettyPrint.print("flake8 is not installed, please visit https://github.com/PyCQA/flake8")
            return []
        }

        var extensionAttributes: [MacExtensionAttribute] = []

        for macExtensionAttribute in macExtensionAttributes {

            guard macExtensionAttribute.inputType == "script",
                let inputData: Data = macExtensionAttribute.scriptContents.data(using: .utf8),
                let scriptType: ScriptType = macExtensionAttribute.scriptContents.scriptType else {
                continue
            }

            let lints: [Lint] = Shell.lintCheck(inputData, type: scriptType, level: level)

            guard !lints.isEmpty else {
                continue
            }

            let extensionAttribute: MacExtensionAttribute = MacExtensionAttribute(
                id: macExtensionAttribute.id,
                name: macExtensionAttribute.name,
                enabled: macExtensionAttribute.enabled,
                dataType: macExtensionAttribute.dataType,
                inputType: macExtensionAttribute.inputType,
                scriptContents: macExtensionAttribute.scriptContents,
                linterWarnings: level == .lintWarning ? lints : [],
                linterErrors: level == .lintError ? lints : []
            )
            extensionAttributes.append(extensionAttribute)
        }

        return extensionAttributes
    }

    /// Returns an array of `Mac Packages` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Packages` that are not linked.
    static func macPackagesNotLinked(_ objects: Objects) -> [MacPackage] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.packages }
        let macPackages: [MacPackage] = objects.macPackages.filter { !identifiers.contains($0.id) }
        return macPackages
    }

    /// Returns an array of `Mac Policies` with no scope.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Policies` with no scope.
    static func macPoliciesNoScope(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        macPolicies.filter { !$0.scope }
    }

    /// Returns an array of `Mac Policies` that are disabled.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Policies` that are disabled.
    static func macPoliciesDisabled(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        macPolicies.filter { !$0.enabled }
    }

    /// Returns an array of `Mac Policies` with no payload.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Policies` with no payload.
    static func macPoliciesNoPayload(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        macPolicies.filter { !$0.payload }
    }

    /// Returns an array of `Mac Policies` that were executed via **Jamf Remote**.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Policies` that were executed via **Jamf Remote**.
    static func macPoliciesJamfRemote(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        let regex: String = "^\\d{4}-\\d{2}-\\d{2} at \\d{1,2}:\\d{2} [AP]M \\| .* \\| \\d+ Computers?$"
        return macPolicies.filter { $0.name.range(of: regex, options: .regularExpression) != nil }
    }

    /// Returns an array of `Mac Policies` that have not executed since the **Last Executed** threshold.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Policies` that have not executed since the **Last Executed** threshold.
    static func macPoliciesLastExecuted(_ objects: Objects, options: [ReportOptionType: Int]) -> [MacPolicy] {
        let lastExecuted: Int = options[.macPoliciesLastExecuted] ?? .defaultOption
        let now: Date = Date()
        let identifiers: [Int] = objects.macDevicesHistory.flatMap { $0.macPolicyLogs }.filter { $0.date.daysSince(now) >= lastExecuted }.map { $0.id }
        let macPolicies: [MacPolicy] = objects.macPolicies.filter { identifiers.contains($0.id) }
        return macPolicies
    }

    /// Returns an array of `Mac Policies` that have failed according to the **Failed** threshold.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Policies` that have failed according to the **Failed** threshold.
    static func macPoliciesFailedThreshold(_ objects: Objects, options: [ReportOptionType: Int]) -> [MacPolicy] {
        let failedThreshold: Int = options[.macPoliciesFailedThreshold] ?? .defaultOption
        let macPolicyLogs: [MacPolicyLog] = objects.macDevicesHistory.flatMap { $0.macPolicyLogs }
        var dictionary: [Int: (failed: Double, total: Double)] = [:]

        for macPolicyLog in macPolicyLogs {
            if dictionary[macPolicyLog.id] == nil {
                dictionary[macPolicyLog.id] = (failed: macPolicyLog.status == "Failed" ? 1 : 0, total: 1)
            } else {
                dictionary[macPolicyLog.id]?.failed += macPolicyLog.status == "Failed" ? 1 : 0
                dictionary[macPolicyLog.id]?.total += 1
            }
        }

        let identifiers: [Int] = dictionary.filter { ($1.failed / $1.total * 100) < Double(failedThreshold) }.map { $0.key }
        let macPolicies: [MacPolicy] = objects.macPolicies.filter { !identifiers.contains($0.id) }
        return macPolicies
    }

    /// Returns an array of `Mac Printers` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Printers` that are not linked.
    static func macPrintersNotLinked(_ objects: Objects) -> [MacPrinter] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.printers }
        let macPrinters: [MacPrinter] = objects.macPrinters.filter { !identifiers.contains($0.id) }
        return macPrinters
    }

    /// Returns an array of `Mac Restricted Softwares` with no scope.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Restricted Softwares` with no scope.
    static func macRestrictedSoftwaresNoScope(_ macRestrictedSoftwares: [MacRestrictedSoftware]) -> [MacRestrictedSoftware] {
        macRestrictedSoftwares.filter { !$0.scope }
    }

    /// Returns an array of `Mac Scripts` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Scripts` that are not linked.
    static func macScriptsNotLinked(_ objects: Objects) -> [MacScript] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.scripts }
        let macScripts: [MacScript] = objects.macScripts.filter { !identifiers.contains($0.id) }
        return macScripts
    }

    /// Returns an array of `Mac Scripts` with linter errors.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Scripts` with linter errors.
    static func macScriptsLinterErrors(_ macScripts: [MacScript]) -> [MacScript] {
        macScriptsLint(macScripts, level: .lintError)
    }

    /// Returns an array of `Mac Scripts` with linter warnings.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Scripts` with linter warnings.
    static func macScriptsLinterWarnings(_ macScripts: [MacScript]) -> [MacScript] {
        macScriptsLint(macScripts, level: .lintWarning)
    }

    /// Helper function to perform `Mac Scripts` linting operations.
    ///
    /// - Parameters:
    ///   - macScripts: The Mac Scripts to filter.
    ///   - level: The linting level (ie. `.lintError` or `.lintWarning`).
    /// - Returns: An array of `Mac Scripts` with linter errors or warnings.
    static func macScriptsLint(_ macScripts: [MacScript], level: LintLevel) -> [MacScript] {

        guard FileManager.default.fileExists(atPath: "/usr/local/bin/shellcheck") else {
            PrettyPrint.print("shellcheck is not installed, please visit https://github.com/koalaman/shellcheck")
            return []
        }

        guard FileManager.default.fileExists(atPath: "/usr/local/bin/flake8") else {
            PrettyPrint.print("flake8 is not installed, please visit https://github.com/PyCQA/flake8")
            return []
        }

        var scripts: [MacScript] = []

        for macScript in macScripts {

            guard let inputData: Data = macScript.scriptContents.data(using: .utf8),
                let scriptType: ScriptType = macScript.scriptContents.scriptType else {
                continue
            }

            let lints: [Lint] = Shell.lintCheck(inputData, type: scriptType, level: level)

            guard !lints.isEmpty else {
                continue
            }

            let script: MacScript = MacScript(id: macScript.id, name: macScript.name, linterWarnings: level == .lintWarning ? lints : [], linterErrors: level == .lintError ? lints : [])
            scripts.append(script)
        }

        return scripts
    }

    /// Returns an array of `Mac Smart Groups` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Smart Groups` that are not linked.
    static func macSmartGroupsNotLinked(_ objects: Objects) -> [SmartGroup] {

        var identifiers: [Int] = []

        for macAdvancedSearch in objects.macAdvancedSearches {
            let values: [String] = macAdvancedSearch.criteria.filter { $0.name == "Computer Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.macSmartGroups.filter { values.contains($0.name) }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macTargets.deviceGroups })
        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macTargets.deviceGroups })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macTargets.deviceGroups })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.macRestrictedSoftwares.flatMap { $0.macTargets.deviceGroups })
        identifiers.append(contentsOf: objects.macRestrictedSoftwares.flatMap { $0.macExclusions.deviceGroups })

        let macSmartGroups: [SmartGroup] = objects.macSmartGroups.filter { !identifiers.contains($0.id) }
        return macSmartGroups
    }

    /// Returns an array of `Mac Smart Groups` with no criteria.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Smart Groups` with no criteria.
    static func macSmartGroupsNoCriteria(_ macSmartGroups: [SmartGroup]) -> [SmartGroup] {
        macSmartGroups.filter { $0.criteria.isEmpty }
    }

    /// Returns an array of `Mac Static Groups` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Static Groups` that are not linked.
    static func macStaticGroupsNotLinked(_ objects: Objects) -> [StaticGroup] {

        var identifiers: [Int] = []

        for macAdvancedSearch in objects.macAdvancedSearches {
            let values: [String] = macAdvancedSearch.criteria.filter { $0.name == "Computer Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.macStaticGroups.filter { values.contains($0.name) }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macTargets.deviceGroups })
        identifiers.append(contentsOf: objects.macApplications.flatMap { $0.macExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macTargets.deviceGroups })
        identifiers.append(contentsOf: objects.macConfigurationProfiles.flatMap { $0.macExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macTargets.deviceGroups })
        identifiers.append(contentsOf: objects.macPolicies.flatMap { $0.macExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.macRestrictedSoftwares.flatMap { $0.macTargets.deviceGroups })

        let macStaticGroups: [StaticGroup] = objects.macStaticGroups.filter { !identifiers.contains($0.id) }
        return macStaticGroups
    }

    /// Returns an array of `Mac Static Groups` that are empty.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mac Static Groups` that are empty.
    static func macStaticGroupsEmpty(_ macStaticGroups: [StaticGroup]) -> [StaticGroup] {
        macStaticGroups.filter { $0.devices.isEmpty }
    }

    /// Returns an array of `Mobile Advanced Searches` with no criteria.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Advanced Searches` with no criteria.
    static func mobileAdvancedSearchesNoCriteria(_ mobileAdvancedSearches: [MobileAdvancedSearch]) -> [MobileAdvancedSearch] {
        mobileAdvancedSearches.filter { $0.criteria.isEmpty }
    }

    /// Returns an array of `Mobile Advanced Searches` with invalid criteria.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Advanced Searches` with invalid criteria.
    static func mobileAdvancedSearchesInvalidCriteria(_ objects: Objects) -> [MobileAdvancedSearch] {
        var identifiers: [Int] = []
        let names: [String] = objects.mobileSmartGroups.map { $0.name } + objects.mobileStaticGroups.map { $0.name }

        for mobileAdvancedSearch in objects.mobileAdvancedSearches {
            for criterion in mobileAdvancedSearch.criteria where criterion.name == "Mobile Device Group" && !names.contains(criterion.value) {
                identifiers.append(mobileAdvancedSearch.id)
            }
        }

        let mobileAdvancedSearches: [MobileAdvancedSearch] = objects.mobileAdvancedSearches.filter { identifiers.contains($0.id) }
        return mobileAdvancedSearches
    }

    /// Returns an array of `Mobile Applications` with no scope.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Applications` with no scope.
    static func mobileApplicationsNoScope(_ mobileApplications: [MobileApplication]) -> [MobileApplication] {
        mobileApplications.filter { !$0.scope }
    }

    /// Returns an array of `Mobile Configuration Profiles` with no scope.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Configuration Profiles` with no scope.
    static func mobileConfigurationProfilesNoScope(_ mobileConfigurationProfiles: [MobileConfigurationProfile]) -> [MobileConfigurationProfile] {
        mobileConfigurationProfiles.filter { !$0.scope }
    }

    /// Returns an array of `Mobile Devices` that have not updated inventory since the **Last Inventory** threshold.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Devices` that have not updated inventory since the **Last Inventory** threshold.
    static func mobileDevicesLastInventory(_ mobileDevices: [MobileDevice], options: [ReportOptionType: Int]) -> [MobileDevice] {
        let lastInventory: Int = options[.mobileDevicesLastInventory] ?? .defaultOption
        let now: Date = Date()
            let mobileDevices: [MobileDevice] = mobileDevices.filter { $0.lastInventory.daysSince(now) >= lastInventory && $0.managed }
        return mobileDevices
    }

    /// Returns an array of `Mobile Devices` that are unmanaged.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Devices` that are unmanaged.
    static func mobileDevicesUnmanaged(_ mobileDevices: [MobileDevice]) -> [MobileDevice] {
        mobileDevices.filter { !$0.managed }
    }

    /// Returns an array of `Mobile Extension Attributes` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Extension Attributes` that are not linked.
    static func mobileExtensionAttributesNotLinked(_ objects: Objects) -> [MobileExtensionAttribute] {

        var names: [String] = []
        let mobileExtensionAttributeNames: [String] = objects.mobileExtensionAttributes.map { $0.name }

        for mobileAdvancedSearch in objects.mobileAdvancedSearches {
            names.append(contentsOf: mobileAdvancedSearch.criteria.filter { mobileExtensionAttributeNames.contains($0.name) }.map { $0.name })
        }

        for mobileSmartGroup in objects.mobileSmartGroups {
            names.append(contentsOf: mobileSmartGroup.criteria.filter { mobileExtensionAttributeNames.contains($0.name) }.map { $0.name })
        }

        let mobileExtensionAttributes: [MobileExtensionAttribute] = objects.mobileExtensionAttributes.filter { !names.contains($0.name) }
        return mobileExtensionAttributes
    }

    /// Returns an array of `Mobile Smart Groups` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Smart Groups` that are not linked.
    static func mobileSmartGroupsNotLinked(_ objects: Objects) -> [SmartGroup] {

        var identifiers: [Int] = []

        for mobileAdvancedSearch in objects.mobileAdvancedSearches {
            let values: [String] = mobileAdvancedSearch.criteria.filter { $0.name == "Mobile Device Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.mobileSmartGroups.filter { values.contains($0.name) }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileExclusions.deviceGroups })

        let mobileSmartGroups: [SmartGroup] = objects.mobileSmartGroups.filter { !identifiers.contains($0.id) }
        return mobileSmartGroups
    }

    /// Returns an array of `Mobile Smart Groups` with no criteria.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Smart Groups` with no criteria.
    static func mobileSmartGroupsNoCriteria(_ mobileSmartGroups: [SmartGroup]) -> [SmartGroup] {
        mobileSmartGroups.filter { $0.criteria.isEmpty }
    }

    /// Returns an array of `Mobile Static Groups` that are not linked.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Static Groups` that are not linked.
    static func mobileStaticGroupsNotLinked(_ objects: Objects) -> [StaticGroup] {

        var identifiers: [Int] = []

        for mobileAdvancedSearch in objects.mobileAdvancedSearches {
            let values: [String] = mobileAdvancedSearch.criteria.filter { $0.name == "Mobile Device Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.mobileStaticGroups.filter { values.contains($0.name) }.map { $0.id })
        }

        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileExclusions.deviceGroups })

        let mobileStaticGroups: [StaticGroup] = objects.mobileStaticGroups.filter { !identifiers.contains($0.id) }
        return mobileStaticGroups
    }

    /// Returns an array of `Mobile Static Groups` that are empty.
    ///
    /// - Parameters:
    ///   - objects: The objects used to generate reports.
    /// - Returns: An array of `Mobile Static Groups` that are empty.
    static func mobileStaticGroupsEmpty(_ mobileStaticGroups: [StaticGroup]) -> [StaticGroup] {
        mobileStaticGroups.filter { $0.devices.isEmpty }
    }
}
