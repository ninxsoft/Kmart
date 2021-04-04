//
//  ReporterMobile.swift
//  KMART
//
//  Created by Nindi Gill on 27/2/21.
//

import Foundation

struct ReporterMobile {

    // swiftlint:disable:next cyclomatic_complexity
    static func update(_ reports: inout Reports, with report: ReportType, from objects: Objects, options: [ReportOptionType: Int]) {

        switch report {
        case .mobileAdvancedSearchesNoCriteria:
            reports.mobileAdvancedSearchesNoCriteria.append(contentsOf: mobileAdvancedSearchesNoCriteria(mobileAdvancedSearchesNoCriteria(objects.mobileAdvancedSearches)))
        case .mobileAdvancedSearchesInvalidCriteria: reports.mobileAdvancedSearchesInvalidCriteria.append(contentsOf: mobileAdvancedSearchesInvalidCriteria(objects))
        case .mobileApplicationsNoScope:             reports.mobileApplicationsNoScope.append(contentsOf: mobileApplicationsNoScope(objects.mobileApplications))
        case .mobileConfigurationProfilesNoScope:    reports.mobileConfigurationProfilesNoScope.append(contentsOf: mobileConfigurationProfilesNoScope(objects.mobileConfigurationProfiles))
        case .mobileDevicesLastInventory:            reports.mobileDevicesLastInventory.append(contentsOf: mobileDevicesLastInventory(objects.mobileDevices, options: options))
        case .mobileExtensionAttributesNotLinked:    reports.mobileExtensionAttributesNotLinked.append(contentsOf: mobileExtensionAttributesNotLinked(objects))
        case .mobileSmartGroupsNotLinked:            reports.mobileSmartGroupsNotLinked.append(contentsOf: mobileSmartGroupsNotLinked(objects))
        case .mobileSmartGroupsNoCriteria:           reports.mobileSmartGroupsNoCriteria.append(contentsOf: mobileSmartGroupsNoCriteria(objects.mobileSmartGroups))
        case .mobileStaticGroupsNotLinked:           reports.mobileStaticGroupsNotLinked.append(contentsOf: mobileStaticGroupsNotLinked(objects))
        case .mobileStaticGroupsEmpty:               reports.mobileStaticGroupsEmpty.append(contentsOf: mobileStaticGroupsEmpty(objects.mobileStaticGroups))
        default:                                     break
        }
    }

    static func mobileAdvancedSearchesNoCriteria(_ mobileAdvancedSearches: [MobileAdvancedSearch]) -> [MobileAdvancedSearch] {
        mobileAdvancedSearches.filter { $0.criteria.isEmpty }
    }

    static func mobileAdvancedSearchesInvalidCriteria(_ objects: Objects) -> [MobileAdvancedSearch] {
        var identifiers: [Int] = []
        let names: [String] = objects.mobileSmartGroups.map { $0.name} + objects.mobileStaticGroups.map { $0.name }

        for mobileAdvancedSearch in objects.mobileAdvancedSearches {
            for criterion in mobileAdvancedSearch.criteria where criterion.name == "Mobile Device Group" && !names.contains(criterion.value) {
                identifiers.append(mobileAdvancedSearch.id)
            }
        }

        let mobileAdvancedSearches: [MobileAdvancedSearch] = objects.mobileAdvancedSearches.filter { identifiers.contains($0.id) }
        return mobileAdvancedSearches
    }

    static func mobileApplicationsNoScope(_ mobileApplications: [MobileApplication]) -> [MobileApplication] {
        mobileApplications.filter { !$0.scope }
    }

    static func mobileConfigurationProfilesNoScope(_ mobileConfigurationProfiles: [MobileConfigurationProfile]) -> [MobileConfigurationProfile] {
        mobileConfigurationProfiles.filter { !$0.scope }
    }

    static func mobileDevicesLastInventory(_ mobileDevices: [MobileDevice], options: [ReportOptionType: Int]) -> [MobileDevice] {
        let lastInventory: Int = options[.mobileDevicesLastInventory] ?? .defaultOption
        let now: Date = Date()
        let mobileDevices: [MobileDevice] = mobileDevices.filter { $0.lastInventory.daysSince(now) >= lastInventory }
        return mobileDevices
    }

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

    static func mobileSmartGroupsNotLinked(_ objects: Objects) -> [SmartGroup] {

        var identifiers: [Int] = []

        for mobileAdvancedSearch in objects.mobileAdvancedSearches {
            let values: [String] = mobileAdvancedSearch.criteria.filter { $0.name == "Mobile Device Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.mobileSmartGroups.filter { values.contains($0.name) }.map { $0.id  })
        }

        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileExclusions.deviceGroups })

        let mobileSmartGroups: [SmartGroup] = objects.mobileSmartGroups.filter { !identifiers.contains($0.id) }
        return mobileSmartGroups
    }

    static func mobileSmartGroupsNoCriteria(_ mobileSmartGroups: [SmartGroup]) -> [SmartGroup] {
        mobileSmartGroups.filter { $0.criteria.isEmpty }
    }

    static func mobileStaticGroupsNotLinked(_ objects: Objects) -> [StaticGroup] {

        var identifiers: [Int] = []

        for mobileAdvancedSearch in objects.mobileAdvancedSearches {
            let values: [String] = mobileAdvancedSearch.criteria.filter { $0.name == "Mobile Device Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.mobileStaticGroups.filter { values.contains($0.name) }.map { $0.id  })
        }

        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileApplications.flatMap { $0.mobileExclusions.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileTargets.deviceGroups })
        identifiers.append(contentsOf: objects.mobileConfigurationProfiles.flatMap { $0.mobileExclusions.deviceGroups })

        let mobileStaticGroups: [StaticGroup] = objects.mobileStaticGroups.filter { !identifiers.contains($0.id) }
        return mobileStaticGroups
    }

    static func mobileStaticGroupsEmpty(_ mobileStaticGroups: [StaticGroup]) -> [StaticGroup] {
        mobileStaticGroups.filter { $0.devices.isEmpty }
    }
}
