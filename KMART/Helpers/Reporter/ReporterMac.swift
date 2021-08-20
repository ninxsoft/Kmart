//
//  ReporterMac.swift
//  KMART
//
//  Created by Nindi Gill on 27/2/21.
//

import Foundation

// swiftlint:disable:next type_body_length
struct ReporterMac {

    // swiftlint:disable cyclomatic_complexity
    static func update(_ reports: inout Reports, with report: ReportType, from objects: Objects, options: [ReportOptionType: Int]) {

        switch report {
        case .macAdvancedSearchesNoCriteria:        reports.macAdvancedSearchesNoCriteria.append(contentsOf: macAdvancedSearchesNoCriteria(objects.macAdvancedSearches))
        case .macAdvancedSearchesInvalidCriteria:   reports.macAdvancedSearchesInvalidCriteria.append(contentsOf: macAdvancedSearchesInvalidCriteria(objects))
        case .macApplicationsNoScope:               reports.macApplicationsNoScope.append(contentsOf: macApplicationsNoScope(objects.macApplications))
        case .macConfigurationProfilesNoScope:      reports.macConfigurationProfilesNoScope.append(contentsOf: macConfigurationProfilesNoScope(objects.macConfigurationProfiles))
        case .macDevicesDuplicateNames:             reports.macDevicesDuplicateNames.append(contentsOf: macDevicesDuplicateNames(objects.macDevices))
        case .macDevicesDuplicateSerialNumbers:     reports.macDevicesDuplicateSerialNumbers.append(contentsOf: macDevicesDuplicateSerialNumbers(objects.macDevices))
        case .macDevicesLastCheckIn:                reports.macDevicesLastCheckIn.append(contentsOf: macDevicesLastCheckIn(objects.macDevices, options: options))
        case .macDevicesLastInventory:              reports.macDevicesLastInventory.append(contentsOf: macDevicesLastInventory(objects.macDevices, options: options))
        case .macDevicesUnmanaged:                  reports.macDevicesUnmanaged.append(contentsOf: macDevicesUnmanaged(objects.macDevices))
        case .macDirectoryBindingsNotLinked:        reports.macDirectoryBindingsNotLinked.append(contentsOf: macDirectoryBindingsNotLinked(objects))
        case .macDiskEncryptionsNotLinked:          reports.macDiskEncryptionsNotLinked.append(contentsOf: macDiskEncryptionsNotLinked(objects))
        case .macDockItemsNotLinked:                reports.macDockItemsNotLinked.append(contentsOf: macDockItemsNotLinked(objects))
        case .macExtensionAttributesNotLinked:      reports.macExtensionAttributesNotLinked.append(contentsOf: macExtensionAttributesNotLinked(objects))
        case .macExtensionAttributesDisabled:       reports.macExtensionAttributesDisabled.append(contentsOf: macExtensionAttributesDisabled(objects.macExtensionAttributes))
        case .macExtensionAttributesLinterErrors:   reports.macExtensionAttributesLinterErrors.append(contentsOf: macExtensionAttributesLinterErrors(objects.macExtensionAttributes))
        case .macExtensionAttributesLinterWarnings: reports.macExtensionAttributesLinterWarnings.append(contentsOf: macExtensionAttributesLinterWarnings(objects.macExtensionAttributes))
        case .macPackagesNotLinked:                 reports.macPackagesNotLinked.append(contentsOf: macPackagesNotLinked(objects))
        case .macPoliciesNoScope:                   reports.macPoliciesNoScope.append(contentsOf: macPoliciesNoScope(objects.macPolicies))
        case .macPoliciesDisabled:                  reports.macPoliciesDisabled.append(contentsOf: macPoliciesDisabled(objects.macPolicies))
        case .macPoliciesNoPayload:                 reports.macPoliciesNoPayload.append(contentsOf: macPoliciesNoPayload(objects.macPolicies))
        case .macPoliciesJamfRemote:                reports.macPoliciesJamfRemote.append(contentsOf: macPoliciesJamfRemote(objects.macPolicies))
        case .macPoliciesLastExecuted:              reports.macPoliciesLastExecuted.append(contentsOf: macPoliciesLastExecuted(objects, options: options))
        case .macPoliciesFailedThreshold:           reports.macPoliciesFailedThreshold.append(contentsOf: macPoliciesFailedThreshold(objects, options: options))
        case .macPrintersNotLinked:                 reports.macPrintersNotLinked.append(contentsOf: macPrintersNotLinked(objects))
        case .macRestrictedSoftwareNoScope:         reports.macRestrictedSoftwaresNoScope.append(contentsOf: macRestrictedSoftwaresNoScope(objects.macRestrictedSoftwares))
        case .macScriptsNotLinked:                  reports.macScriptsNotLinked.append(contentsOf: macScriptsNotLinked(objects))
        case .macScriptsLinterErrors:               reports.macScriptsLinterErrors.append(contentsOf: macScriptsLinterErrors(objects.macScripts))
        case .macScriptsLinterWarnings:             reports.macScriptsLinterWarnings.append(contentsOf: macScriptLinterWarnings(objects.macScripts))
        case .macSmartGroupsNotLinked:              reports.macSmartGroupsNotLinked.append(contentsOf: macSmartGroupsNotLinked(objects))
        case .macSmartGroupsNoCriteria:             reports.macSmartGroupsNoCriteria.append(contentsOf: macSmartGroupsNoCriteria(objects.macSmartGroups))
        case .macStaticGroupsNotLinked:             reports.macStaticGroupsNotLinked.append(contentsOf: macStaticGroupsNotLinked(objects))
        case .macStaticGroupsEmpty:                 reports.macStaticGroupsEmpty.append(contentsOf: macStaticGroupsEmpty(objects.macStaticGroups))
        default:                                    break
        }
    }

    static func macAdvancedSearchesNoCriteria(_ macAdvancedSearches: [MacAdvancedSearch]) -> [MacAdvancedSearch] {
        macAdvancedSearches.filter { $0.criteria.isEmpty }
    }

    static func macAdvancedSearchesInvalidCriteria(_ objects: Objects) -> [MacAdvancedSearch] {
        var identifiers: [Int] = []
        let names: [String] = objects.macSmartGroups.map { $0.name} + objects.macStaticGroups.map { $0.name }

        for macAdvancedSearch in objects.macAdvancedSearches {
            for criterion in macAdvancedSearch.criteria where criterion.name == "Computer Group" && !names.contains(criterion.value) {
                identifiers.append(macAdvancedSearch.id)
            }
        }

        let macAdvancedSearches: [MacAdvancedSearch] = objects.macAdvancedSearches.filter { identifiers.contains($0.id) }
        return macAdvancedSearches
    }

    static func macApplicationsNoScope(_ macApplications: [MacApplication]) -> [MacApplication] {
        macApplications.filter { !$0.scope }
    }

    static func macConfigurationProfilesNoScope(_ macConfigurationProfiles: [MacConfigurationProfile]) -> [MacConfigurationProfile] {
        macConfigurationProfiles.filter { !$0.scope }
    }

    static func macDevicesDuplicateNames(_ macDevices: [MacDevice]) -> [MacDevice] {
        let identifiers: [Int] = Dictionary(grouping: macDevices) { $0.name }.filter { $1.count == 1 }.flatMap { $1 }.map { $0.id }
        return macDevices.filter { !identifiers.contains($0.id) }.sorted { $0.name < $1.name }
    }

    static func macDevicesDuplicateSerialNumbers(_ macDevices: [MacDevice]) -> [MacDevice] {
        let identifiers: [Int] = Dictionary(grouping: macDevices) { $0.serialNumber }.filter { $1.count == 1 }.flatMap { $1 }.map { $0.id }
        return macDevices.filter { !identifiers.contains($0.id) }.sorted { $0.serialNumber < $1.serialNumber }
    }

    static func macDevicesLastCheckIn(_ macDevices: [MacDevice], options: [ReportOptionType: Int]) -> [MacDevice] {
        let lastCheckIn: Int = options[.macDevicesLastCheckIn] ?? .defaultOption
        let now: Date = Date()
        return macDevices.filter { $0.lastCheckIn.daysSince(now) >= lastCheckIn && $0.managed }
    }

    static func macDevicesLastInventory(_ macDevices: [MacDevice], options: [ReportOptionType: Int]) -> [MacDevice] {
        let lastInventory: Int = options[.macDevicesLastInventory] ?? .defaultOption
        let now: Date = Date()
        return macDevices.filter { $0.lastInventory.daysSince(now) >= lastInventory && $0.managed }
    }

    static func macDevicesUnmanaged(_ macDevices: [MacDevice]) -> [MacDevice] {
        macDevices.filter { !$0.managed }
    }

    static func macDirectoryBindingsNotLinked(_ objects: Objects) -> [MacDirectoryBinding] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.directoryBindings }
        let macDirectoryBindings: [MacDirectoryBinding] = objects.macDirectoryBindings.filter { !identifiers.contains($0.id) }
        return macDirectoryBindings
    }

    static func macDiskEncryptionsNotLinked(_ objects: Objects) -> [MacDiskEncryption] {
        let identifiers: [Int] = objects.macPolicies.map { $0.diskEncryption }
        let macDiskEncryptions: [MacDiskEncryption] = objects.macDiskEncryptions.filter { !identifiers.contains($0.id) }
        return macDiskEncryptions
    }

    static func macDockItemsNotLinked(_ objects: Objects) -> [MacDockItem] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.dockItems }
        let macDockItems: [MacDockItem] = objects.macDockItems.filter { !identifiers.contains($0.id) }
        return macDockItems
    }

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

    static func macExtensionAttributesDisabled(_ macExtensionAttributes: [MacExtensionAttribute]) -> [MacExtensionAttribute] {
        macExtensionAttributes.filter { $0.inputType == "Script" && !$0.enabled }
    }

    static func macExtensionAttributesLinterErrors(_ macExtensionAttributes: [MacExtensionAttribute]) -> [MacExtensionAttribute] {
        macExtensionAttributesLint(macExtensionAttributes, level: .lintError)
    }

    static func macExtensionAttributesLinterWarnings(_ macExtensionAttributes: [MacExtensionAttribute]) -> [MacExtensionAttribute] {
        macExtensionAttributesLint(macExtensionAttributes, level: .lintWarning)
    }

    private static func macExtensionAttributesLint(_ macExtensionAttributes: [MacExtensionAttribute], level: LintLevel) -> [MacExtensionAttribute] {

        guard FileManager.default.fileExists(atPath: "/usr/local/bin/shellcheck") else {
            PrettyPrint.print(.error, string: "shellcheck is not installed, please visit https://github.com/koalaman/shellcheck")
            return []
        }

        var extensionAttributes: [MacExtensionAttribute] = []

        for macExtensionAttribute in macExtensionAttributes {

            guard macExtensionAttribute.inputType == "script",
                let inputData: Data = macExtensionAttribute.scriptContents.data(using: .utf8),
                let lints: [Lint] = Shell.shellcheck(inputData, level: level),
                !lints.isEmpty else {
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

    static func macPackagesNotLinked(_ objects: Objects) -> [MacPackage] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.packages }
        let macPackages: [MacPackage] = objects.macPackages.filter { !identifiers.contains($0.id) }
        return macPackages
    }

    static func macPoliciesNoScope(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        macPolicies.filter { !$0.scope }
    }

    static func macPoliciesDisabled(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        macPolicies.filter { !$0.enabled }
    }

    static func macPoliciesNoPayload(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        macPolicies.filter { !$0.payload }
    }

    static func macPoliciesJamfRemote(_ macPolicies: [MacPolicy]) -> [MacPolicy] {
        let regex: String = "^\\d{4}-\\d{2}-\\d{2} at \\d{1,2}:\\d{2} [AP]M \\| .* \\| \\d+ Computers?$"
        return macPolicies.filter { $0.name.range(of: regex, options: .regularExpression) != nil }
    }

    static func macPoliciesLastExecuted(_ objects: Objects, options: [ReportOptionType: Int]) -> [MacPolicy] {
        let lastExecuted: Int = options[.macPoliciesLastExecuted] ?? .defaultOption
        let now: Date = Date()
        let identifiers: [Int] = objects.macDevicesHistory.flatMap { $0.macPolicyLogs }.filter { $0.date.daysSince(now) >= lastExecuted }.map { $0.id }
        let macPolicies: [MacPolicy] = objects.macPolicies.filter { identifiers.contains($0.id) }
        return macPolicies
    }

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

    static func macPrintersNotLinked(_ objects: Objects) -> [MacPrinter] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.printers }
        let macPrinters: [MacPrinter] = objects.macPrinters.filter { !identifiers.contains($0.id) }
        return macPrinters
    }

    static func macRestrictedSoftwaresNoScope(_ macRestrictedSoftwares: [MacRestrictedSoftware]) -> [MacRestrictedSoftware] {
        macRestrictedSoftwares.filter { !$0.scope }
    }

    static func macScriptsNotLinked(_ objects: Objects) -> [MacScript] {
        let identifiers: [Int] = objects.macPolicies.flatMap { $0.scripts }
        let macScripts: [MacScript] = objects.macScripts.filter { !identifiers.contains($0.id) }
        return macScripts
    }

    static func macScriptsLinterErrors(_ macScripts: [MacScript]) -> [MacScript] {
        macScriptsLint(macScripts, level: .lintError)
    }

    static func macScriptLinterWarnings(_ macScripts: [MacScript]) -> [MacScript] {
        macScriptsLint(macScripts, level: .lintWarning)
    }

    private static func macScriptsLint(_ macScripts: [MacScript], level: LintLevel) -> [MacScript] {

        guard FileManager.default.fileExists(atPath: "/usr/local/bin/shellcheck") else {
            PrettyPrint.print(.error, string: "shellcheck is not installed, please visit https://github.com/koalaman/shellcheck")
            return []
        }

        var scripts: [MacScript] = []

        for macScript in macScripts {

            guard let inputData: Data = macScript.scriptContents.data(using: .utf8),
                let lints: [Lint] = Shell.shellcheck(inputData, level: level),
                !lints.isEmpty else {
                continue
            }

            let script: MacScript = MacScript(id: macScript.id, name: macScript.name, linterWarnings: level == .lintWarning ? lints : [], linterErrors: level == .lintError ? lints : [])
            scripts.append(script)
        }

        return scripts
    }

    static func macSmartGroupsNotLinked(_ objects: Objects) -> [SmartGroup] {

        var identifiers: [Int] = []

        for macAdvancedSearch in objects.macAdvancedSearches {
            let values: [String] = macAdvancedSearch.criteria.filter { $0.name == "Computer Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.macSmartGroups.filter { values.contains($0.name) }.map { $0.id  })
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

    static func macSmartGroupsNoCriteria(_ macSmartGroups: [SmartGroup]) -> [SmartGroup] {
        macSmartGroups.filter { $0.criteria.isEmpty }
    }

    static func macStaticGroupsNotLinked(_ objects: Objects) -> [StaticGroup] {

        var identifiers: [Int] = []

        for macAdvancedSearch in objects.macAdvancedSearches {
            let values: [String] = macAdvancedSearch.criteria.filter { $0.name == "Computer Group" }.map { $0.value }
            identifiers.append(contentsOf: objects.macStaticGroups.filter { values.contains($0.name) }.map { $0.id  })
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

    static func macStaticGroupsEmpty(_ macStaticGroups: [StaticGroup]) -> [StaticGroup] {
        macStaticGroups.filter { $0.devices.isEmpty }
    }
}
