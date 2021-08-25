//
//  Reports.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation
import Yams

struct Reports {
    var buildingsNotLinked: [Building] = []
    var categoriesNotLinked: [Category] = []
    var departmentsNotLinked: [Department] = []
    var eBooksNoScope: [EBook] = []
    var iBeaconsNotLinked: [IBeacon] = []
    var macAdvancedSearchesNoCriteria: [MacAdvancedSearch] = []
    var macAdvancedSearchesInvalidCriteria: [MacAdvancedSearch] = []
    var macApplicationsNoScope: [MacApplication] = []
    var macConfigurationProfilesNoScope: [MacConfigurationProfile] = []
    var macDevicesDuplicateNames: [MacDevice] = []
    var macDevicesDuplicateSerialNumbers: [MacDevice] = []
    var macDevicesLastCheckIn: [MacDevice] = []
    var macDevicesLastInventory: [MacDevice] = []
    var macDevicesUnmanaged: [MacDevice] = []
    var macDirectoryBindingsNotLinked: [MacDirectoryBinding] = []
    var macDiskEncryptionsNotLinked: [MacDiskEncryption] = []
    var macDockItemsNotLinked: [MacDockItem] = []
    var macExtensionAttributesNotLinked: [MacExtensionAttribute] = []
    var macExtensionAttributesDisabled: [MacExtensionAttribute] = []
    var macExtensionAttributesLinterErrors: [MacExtensionAttribute] = []
    var macExtensionAttributesLinterWarnings: [MacExtensionAttribute] = []
    var macPackagesNotLinked: [MacPackage] = []
    var macPoliciesNoScope: [MacPolicy] = []
    var macPoliciesDisabled: [MacPolicy] = []
    var macPoliciesNoPayload: [MacPolicy] = []
    var macPoliciesJamfRemote: [MacPolicy] = []
    var macPoliciesLastExecuted: [MacPolicy] = []
    var macPoliciesFailedThreshold: [MacPolicy] = []
    var macPrintersNotLinked: [MacPrinter] = []
    var macRestrictedSoftwaresNoScope: [MacRestrictedSoftware] = []
    var macScriptsNotLinked: [MacScript] = []
    var macScriptsLinterErrors: [MacScript] = []
    var macScriptsLinterWarnings: [MacScript] = []
    var macSmartGroupsNotLinked: [SmartGroup] = []
    var macSmartGroupsNoCriteria: [SmartGroup] = []
    var macStaticGroupsNotLinked: [StaticGroup] = []
    var macStaticGroupsEmpty: [StaticGroup] = []
    var mobileAdvancedSearchesNoCriteria: [MobileAdvancedSearch] = []
    var mobileAdvancedSearchesInvalidCriteria: [MobileAdvancedSearch] = []
    var mobileApplicationsNoScope: [MobileApplication] = []
    var mobileConfigurationProfilesNoScope: [MobileConfigurationProfile] = []
    var mobileDevicesLastInventory: [MobileDevice] = []
    var mobileDevicesUnmanaged: [MobileDevice] = []
    var mobileExtensionAttributesNotLinked: [MobileExtensionAttribute] = []
    var mobileSmartGroupsNotLinked: [SmartGroup] = []
    var mobileSmartGroupsNoCriteria: [SmartGroup] = []
    var mobileStaticGroupsNotLinked: [StaticGroup] = []
    var mobileStaticGroupsEmpty: [StaticGroup] = []
    var networkSegmentsNotLinked: [NetworkSegment] = []

    private func getDictionary(reports: [ReportType], using configuration: Configuration) -> [String: Any] {

        let reportTypes: [ReportType] = reports.sorted { $0.identifier < $1.identifier }
        var reportsDictionary: [String: Any] = [:]

        for report in reportTypes {
            switch report.group {
            case .common: reportsDictionary[report.identifier] = getCommonDictionaries(for: report)
            case .mac:    reportsDictionary[report.identifier] = getMacDictionaries(for: report)
            case .mobile: reportsDictionary[report.identifier] = getMobileDictionaries(for: report)
            }
        }

        return ["name": configuration.name, "url": configuration.url, "reports": reportsDictionary]
    }

    private func getCommonDictionaries(for report: ReportType) -> [[String: Any]] {

        switch report {
        case .buildingsNotLinked:       return buildingsNotLinked.map { $0.dictionary }
        case .categoriesNotLinked:      return categoriesNotLinked.map { $0.dictionary }
        case .departmentsNotLinked:     return departmentsNotLinked.map { $0.dictionary }
        case .eBooksNoScope:            return eBooksNoScope.map { $0.dictionary }
        case .iBeaconsNotLinked:        return iBeaconsNotLinked.map { $0.dictionary }
        case .networkSegmentsNotLinked: return networkSegmentsNotLinked.map { $0.dictionary }
        default:                        return []
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func getMacDictionaries(for report: ReportType) -> [[String: Any]] {

        switch report {
        case .macAdvancedSearchesNoCriteria:        return macAdvancedSearchesNoCriteria.map { $0.dictionary }
        case .macAdvancedSearchesInvalidCriteria:   return macAdvancedSearchesInvalidCriteria.map { $0.dictionary }
        case .macApplicationsNoScope:               return macApplicationsNoScope.map { $0.dictionary }
        case .macConfigurationProfilesNoScope:      return macConfigurationProfilesNoScope.map { $0.dictionary }
        case .macDevicesDuplicateNames:             return macDevicesDuplicateNames.map { $0.dictionary }
        case .macDevicesDuplicateSerialNumbers:     return macDevicesDuplicateSerialNumbers.map { $0.dictionary }
        case .macDevicesLastCheckIn:                return macDevicesLastCheckIn.map { $0.dictionary }
        case .macDevicesLastInventory:              return macDevicesLastInventory.map { $0.dictionary }
        case .macDevicesUnmanaged:                  return macDevicesUnmanaged.map { $0.dictionary }
        case .macDirectoryBindingsNotLinked:        return macDirectoryBindingsNotLinked.map { $0.dictionary }
        case .macDiskEncryptionsNotLinked:          return macDiskEncryptionsNotLinked.map { $0.dictionary }
        case .macDockItemsNotLinked:                return macDockItemsNotLinked.map { $0.dictionary }
        case .macExtensionAttributesNotLinked:      return macExtensionAttributesNotLinked.map { $0.dictionary }
        case .macExtensionAttributesDisabled:       return macExtensionAttributesDisabled.map { $0.dictionary }
        case .macExtensionAttributesLinterErrors:   return macExtensionAttributesLinterErrors.map { $0.linterErrorsDictionary }
        case .macExtensionAttributesLinterWarnings: return macExtensionAttributesLinterWarnings.map { $0.linterWarningsDictionary }
        case .macPackagesNotLinked:                 return macPackagesNotLinked.map { $0.dictionary }
        case .macPoliciesNoScope:                   return macPoliciesNoScope.map { $0.dictionary }
        case .macPoliciesDisabled:                  return macPoliciesDisabled.map { $0.dictionary }
        case .macPoliciesNoPayload:                 return macPoliciesNoPayload.map { $0.dictionary }
        case .macPoliciesJamfRemote:                return macPoliciesJamfRemote.map { $0.dictionary }
        case .macPoliciesLastExecuted:              return macPoliciesLastExecuted.map { $0.dictionary }
        case .macPoliciesFailedThreshold:           return macPoliciesFailedThreshold.map { $0.dictionary }
        case .macPrintersNotLinked:                 return macPrintersNotLinked.map { $0.dictionary }
        case .macRestrictedSoftwareNoScope:         return macRestrictedSoftwaresNoScope.map { $0.dictionary }
        case .macScriptsNotLinked:                  return macScriptsNotLinked.map { $0.dictionary }
        case .macScriptsLinterErrors:               return macScriptsLinterErrors.map { $0.linterErrorsDictionary }
        case .macScriptsLinterWarnings:             return macScriptsLinterWarnings.map { $0.linterWarningsDictionary }
        case .macSmartGroupsNotLinked:              return macSmartGroupsNotLinked.map { $0.dictionary }
        case .macSmartGroupsNoCriteria:             return macSmartGroupsNoCriteria.map { $0.dictionary }
        case .macStaticGroupsNotLinked:             return macStaticGroupsNotLinked.map { $0.dictionary }
        case .macStaticGroupsEmpty:                 return macStaticGroupsEmpty.map { $0.dictionary }
        default: return []
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func getMobileDictionaries(for report: ReportType) -> [[String: Any]] {

        switch report {
        case .mobileAdvancedSearchesNoCriteria:      return mobileAdvancedSearchesNoCriteria.map { $0.dictionary }
        case .mobileAdvancedSearchesInvalidCriteria: return mobileAdvancedSearchesInvalidCriteria.map { $0.dictionary }
        case .mobileApplicationsNoScope:             return mobileApplicationsNoScope.map { $0.dictionary }
        case .mobileConfigurationProfilesNoScope:    return mobileConfigurationProfilesNoScope.map { $0.dictionary }
        case .mobileDevicesLastInventory:            return mobileDevicesLastInventory.map { $0.dictionary }
        case .mobileDevicesUnmanaged:                return mobileDevicesUnmanaged.map { $0.dictionary }
        case .mobileExtensionAttributesNotLinked:    return mobileExtensionAttributesNotLinked.map { $0.dictionary }
        case .mobileSmartGroupsNotLinked:            return mobileSmartGroupsNotLinked.map { $0.dictionary }
        case .mobileSmartGroupsNoCriteria:           return mobileSmartGroupsNoCriteria.map { $0.dictionary }
        case .mobileStaticGroupsNotLinked:           return mobileStaticGroupsNotLinked.map { $0.dictionary }
        case .mobileStaticGroupsEmpty:               return mobileStaticGroupsEmpty.map { $0.dictionary }
        default:                                     return []
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
