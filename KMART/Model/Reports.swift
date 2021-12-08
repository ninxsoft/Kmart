//
//  Reports.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation
import Yams

// swiftlint:disable:next type_body_length
struct Reports {
    /// buildings not linked
    var buildingsNotLinked: [Building] = []
    /// categories not linked
    var categoriesNotLinked: [Category] = []
    /// departments not linked
    var departmentsNotLinked: [Department] = []
    /// ebooks no scope
    var eBooksNoScope: [EBook] = []
    // ibeacons not linked
    var iBeaconsNotLinked: [IBeacon] = []
    /// mac advanceds searches no criteria
    var macAdvancedSearchesNoCriteria: [MacAdvancedSearch] = []
    /// mac advanced searches invalid criteria
    var macAdvancedSearchesInvalidCriteria: [MacAdvancedSearch] = []
    /// mac applications no scope
    var macApplicationsNoScope: [MacApplication] = []
    /// mac configuration profiles no scope
    var macConfigurationProfilesNoScope: [MacConfigurationProfile] = []
    /// mac devices duplicate names
    var macDevicesDuplicateNames: [MacDevice] = []
    /// mac devices duplicate serial numbers
    var macDevicesDuplicateSerialNumbers: [MacDevice] = []
    /// mac devices last check in
    var macDevicesLastCheckIn: [MacDevice] = []
    /// mac devices last inventory
    var macDevicesLastInventory: [MacDevice] = []
    /// mac devices unmanaged
    var macDevicesUnmanaged: [MacDevice] = []
    /// mac directory bindings not linked
    var macDirectoryBindingsNotLinked: [MacDirectoryBinding] = []
    /// mac disk encryptions not linked
    var macDiskEncryptionsNotLinked: [MacDiskEncryption] = []
    /// mac dock items not linked
    var macDockItemsNotLinked: [MacDockItem] = []
    /// mac extension attributes not linked
    var macExtensionAttributesNotLinked: [MacExtensionAttribute] = []
    /// mac extension attributes disabled
    var macExtensionAttributesDisabled: [MacExtensionAttribute] = []
    /// mac extension attributes linter errors
    var macExtensionAttributesLinterErrors: [MacExtensionAttribute] = []
    /// mac extension attributes linter warnings
    var macExtensionAttributesLinterWarnings: [MacExtensionAttribute] = []
    /// mac packages not linked
    var macPackagesNotLinked: [MacPackage] = []
    /// mac policies no scope
    var macPoliciesNoScope: [MacPolicy] = []
    /// mac policies disabled
    var macPoliciesDisabled: [MacPolicy] = []
    /// mac policies no payload
    var macPoliciesNoPayload: [MacPolicy] = []
    /// mac policies jamf remote
    var macPoliciesJamfRemote: [MacPolicy] = []
    /// mac policies last executed
    var macPoliciesLastExecuted: [MacPolicy] = []
    /// mac policies failed threshold
    var macPoliciesFailedThreshold: [MacPolicy] = []
    /// mac printers not linked
    var macPrintersNotLinked: [MacPrinter] = []
    /// mac restricted softwares no scope
    var macRestrictedSoftwaresNoScope: [MacRestrictedSoftware] = []
    /// mac scripts not linked
    var macScriptsNotLinked: [MacScript] = []
    /// mac scripts linter errors
    var macScriptsLinterErrors: [MacScript] = []
    /// mac scripts linter warnings
    var macScriptsLinterWarnings: [MacScript] = []
    /// mac smart groups not linked
    var macSmartGroupsNotLinked: [SmartGroup] = []
    /// mac smart groups no criteria
    var macSmartGroupsNoCriteria: [SmartGroup] = []
    /// mac static groups not linked
    var macStaticGroupsNotLinked: [StaticGroup] = []
    /// mac static groups empty
    var macStaticGroupsEmpty: [StaticGroup] = []
    /// mobile advanced searches no criteria
    var mobileAdvancedSearchesNoCriteria: [MobileAdvancedSearch] = []
    /// mobile advanced searches invalid criteria
    var mobileAdvancedSearchesInvalidCriteria: [MobileAdvancedSearch] = []
    /// mobile applications no scope
    var mobileApplicationsNoScope: [MobileApplication] = []
    /// mobile configuration profiles no scope
    var mobileConfigurationProfilesNoScope: [MobileConfigurationProfile] = []
    /// mobile devices last inventory
    var mobileDevicesLastInventory: [MobileDevice] = []
    /// mobile devices unmanaged
    var mobileDevicesUnmanaged: [MobileDevice] = []
    /// mobile extension attributes not linked
    var mobileExtensionAttributesNotLinked: [MobileExtensionAttribute] = []
    /// mobile smart groups not linked
    var mobileSmartGroupsNotLinked: [SmartGroup] = []
    /// mobile smart groups no criteria
    var mobileSmartGroupsNoCriteria: [SmartGroup] = []
    /// mobile static groups not linked
    var mobileStaticGroupsNotLinked: [StaticGroup] = []
    /// mobile static groups empty
    var mobileStaticGroupsEmpty: [StaticGroup] = []
    /// network segments not linked
    var networkSegmentsNotLinked: [NetworkSegment] = []

    private func getDictionary(reports: [ReportType], using configuration: Configuration) -> [String: Any] {

        let reportTypes: [ReportType] = reports.sorted { $0.identifier < $1.identifier }
        var reportsDictionary: [String: Any] = [:]

        for report in reportTypes {
            switch report.group {
            case .common:
                reportsDictionary[report.identifier] = getCommonDictionaries(for: report)
            case .mac:
                reportsDictionary[report.identifier] = getMacDictionaries(for: report)
            case .mobile:
                reportsDictionary[report.identifier] = getMobileDictionaries(for: report)
            }
        }

        return ["name": configuration.name, "url": configuration.url, "reports": reportsDictionary]
    }

    private func getCommonDictionaries(for report: ReportType) -> [[String: Any]] {

        switch report {
        case .buildingsNotLinked:
            return buildingsNotLinked.map { $0.dictionary }
        case .categoriesNotLinked:
            return categoriesNotLinked.map { $0.dictionary }
        case .departmentsNotLinked:
            return departmentsNotLinked.map { $0.dictionary }
        case .eBooksNoScope:
            return eBooksNoScope.map { $0.dictionary }
        case .iBeaconsNotLinked:
            return iBeaconsNotLinked.map { $0.dictionary }
        case .networkSegmentsNotLinked:
            return networkSegmentsNotLinked.map { $0.dictionary }
        default:
            return []
        }
    }

    // swiftlint:disable:next cyclomatic_complexity function_body_length
    private func getMacDictionaries(for report: ReportType) -> [[String: Any]] {

        switch report {
        case .macAdvancedSearchesNoCriteria:
            return macAdvancedSearchesNoCriteria.map { $0.dictionary }
        case .macAdvancedSearchesInvalidCriteria:
            return macAdvancedSearchesInvalidCriteria.map { $0.dictionary }
        case .macApplicationsNoScope:
            return macApplicationsNoScope.map { $0.dictionary }
        case .macConfigurationProfilesNoScope:
            return macConfigurationProfilesNoScope.map { $0.dictionary }
        case .macDevicesDuplicateNames:
            return macDevicesDuplicateNames.map { $0.dictionary }
        case .macDevicesDuplicateSerialNumbers:
            return macDevicesDuplicateSerialNumbers.map { $0.dictionary }
        case .macDevicesLastCheckIn:
            return macDevicesLastCheckIn.map { $0.dictionary }
        case .macDevicesLastInventory:
            return macDevicesLastInventory.map { $0.dictionary }
        case .macDevicesUnmanaged:
            return macDevicesUnmanaged.map { $0.dictionary }
        case .macDirectoryBindingsNotLinked:
            return macDirectoryBindingsNotLinked.map { $0.dictionary }
        case .macDiskEncryptionsNotLinked:
            return macDiskEncryptionsNotLinked.map { $0.dictionary }
        case .macDockItemsNotLinked:
            return macDockItemsNotLinked.map { $0.dictionary }
        case .macExtensionAttributesNotLinked:
            return macExtensionAttributesNotLinked.map { $0.dictionary }
        case .macExtensionAttributesDisabled:
            return macExtensionAttributesDisabled.map { $0.dictionary }
        case .macExtensionAttributesLinterErrors:
            return macExtensionAttributesLinterErrors.map { $0.linterErrorsDictionary }
        case .macExtensionAttributesLinterWarnings:
            return macExtensionAttributesLinterWarnings.map { $0.linterWarningsDictionary }
        case .macPackagesNotLinked:
            return macPackagesNotLinked.map { $0.dictionary }
        case .macPoliciesNoScope:
            return macPoliciesNoScope.map { $0.dictionary }
        case .macPoliciesDisabled:
            return macPoliciesDisabled.map { $0.dictionary }
        case .macPoliciesNoPayload:
            return macPoliciesNoPayload.map { $0.dictionary }
        case .macPoliciesJamfRemote:
            return macPoliciesJamfRemote.map { $0.dictionary }
        case .macPoliciesLastExecuted:
            return macPoliciesLastExecuted.map { $0.dictionary }
        case .macPoliciesFailedThreshold:
            return macPoliciesFailedThreshold.map { $0.dictionary }
        case .macPrintersNotLinked:
            return macPrintersNotLinked.map { $0.dictionary }
        case .macRestrictedSoftwareNoScope:
            return macRestrictedSoftwaresNoScope.map { $0.dictionary }
        case .macScriptsNotLinked:
            return macScriptsNotLinked.map { $0.dictionary }
        case .macScriptsLinterErrors:
            return macScriptsLinterErrors.map { $0.linterErrorsDictionary }
        case .macScriptsLinterWarnings:
            return macScriptsLinterWarnings.map { $0.linterWarningsDictionary }
        case .macSmartGroupsNotLinked:
            return macSmartGroupsNotLinked.map { $0.dictionary }
        case .macSmartGroupsNoCriteria:
            return macSmartGroupsNoCriteria.map { $0.dictionary }
        case .macStaticGroupsNotLinked:
            return macStaticGroupsNotLinked.map { $0.dictionary }
        case .macStaticGroupsEmpty:
            return macStaticGroupsEmpty.map { $0.dictionary }
        default:
            return []
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func getMobileDictionaries(for report: ReportType) -> [[String: Any]] {

        switch report {
        case .mobileAdvancedSearchesNoCriteria:
            return mobileAdvancedSearchesNoCriteria.map { $0.dictionary }
        case .mobileAdvancedSearchesInvalidCriteria:
            return mobileAdvancedSearchesInvalidCriteria.map { $0.dictionary }
        case .mobileApplicationsNoScope:
            return mobileApplicationsNoScope.map { $0.dictionary }
        case .mobileConfigurationProfilesNoScope:
            return mobileConfigurationProfilesNoScope.map { $0.dictionary }
        case .mobileDevicesLastInventory:
            return mobileDevicesLastInventory.map { $0.dictionary }
        case .mobileDevicesUnmanaged:
            return mobileDevicesUnmanaged.map { $0.dictionary }
        case .mobileExtensionAttributesNotLinked:
            return mobileExtensionAttributesNotLinked.map { $0.dictionary }
        case .mobileSmartGroupsNotLinked:
            return mobileSmartGroupsNotLinked.map { $0.dictionary }
        case .mobileSmartGroupsNoCriteria:
            return mobileSmartGroupsNoCriteria.map { $0.dictionary }
        case .mobileStaticGroupsNotLinked:
            return mobileStaticGroupsNotLinked.map { $0.dictionary }
        case .mobileStaticGroupsEmpty:
            return mobileStaticGroupsEmpty.map { $0.dictionary }
        default:
            return []
        }
    }

    func saveToDisk(using configuration: Configuration) {

        let reports: [ReportType] = configuration.reports
        let output: [OutputType: String] = configuration.output
        let dictionary: [String: Any] = getDictionary(reports: reports, using: configuration)

        for format in OutputType.allCases {

            guard var path: String = output[format] else {
                continue
            }

            path = path.replacingOccurrences(of: "~", with: NSHomeDirectory())

            do {
                switch format {
                case .json:
                    let data: Data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
                    if let string: String = String(data: data, encoding: .utf8) {
                        try string.write(toFile: path, atomically: true, encoding: .utf8)
                        PrettyPrint.print("Saving report as JSON: \(path)")
                    }
                case .propertyList:
                    let data: Data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: .bitWidth)
                    if let string: String = String(data: data, encoding: .utf8) {
                        try string.write(toFile: path, atomically: true, encoding: .utf8)
                        PrettyPrint.print("Saving report as Propery List: \(path)")
                    }
                case .yaml:
                    let string: String = try Yams.dump(object: dictionary)
                    try string.write(toFile: path, atomically: true, encoding: .utf8)
                    PrettyPrint.print("Saving report as YAML: \(path)")
                case .markdown:
                    let string: String = Markdown.generateMarkdown(from: dictionary, name: configuration.name, url: configuration.url)
                    try string.write(toFile: path, atomically: true, encoding: .utf8)
                    PrettyPrint.print("Saving report as Markdown: \(path)")
                case .html:
                    let string: String = Markdown.generateHTML(from: dictionary, name: configuration.name, url: configuration.url)
                    try string.write(toFile: path, atomically: true, encoding: .utf8)
                    PrettyPrint.print("Saving report as HTML: \(path)")
                }
            } catch {
                PrettyPrint.print(error.localizedDescription)
            }
        }
    }

    func data(type: OutputType, using configuration: Configuration) -> Data? {

        let reports: [ReportType] = configuration.reports
        let dictionary: [String: Any] = getDictionary(reports: reports, using: configuration)

        do {
            switch type {
            case .json:
                let data: Data = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted, .withoutEscapingSlashes])
                if let string: String = String(data: data, encoding: .utf8) {
                    return string.data(using: .utf8)
                }
            case .propertyList:
                let data: Data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: .bitWidth)
                if let string: String = String(data: data, encoding: .utf8) {
                    return string.data(using: .utf8)
                }
            case .yaml:
                let string: String = try Yams.dump(object: dictionary)
                return string.data(using: .utf8)
            case .markdown:
                let string: String = Markdown.generateMarkdown(from: dictionary, name: configuration.name, url: configuration.url)
                return string.data(using: .utf8)
            case .html:
                let string: String = Markdown.generateHTML(from: dictionary, name: configuration.name, url: configuration.url)
                return string.data(using: .utf8)
            }
        } catch {
            PrettyPrint.print(error.localizedDescription)
        }

        return nil
    }
}
