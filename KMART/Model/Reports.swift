//
//  Reports.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation
import Yams

// swiftlint:disable type_body_length

/// Reports struct storing all generated reports.
struct Reports {
    /// buildings not linked
    var buildingsNotLinked: [Building] = []
    /// categories not linked
    var categoriesNotLinked: [Category] = []
    /// departments not linked
    var departmentsNotLinked: [Department] = []
    /// ebooks no scope
    var eBooksNoScope: [EBook] = []
    /// ibeacons not linked
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

    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length

    /// Generates and returns a dictionary containing all requested report types.
    ///
    /// - Parameters:
    ///   - reports: The list of requested reports.
    ///   - configuration: The configuration used to generate the report data.
    /// - Returns: A dictionary containing all specified reports.
    private func getDictionary(reports: [ReportType], using configuration: Configuration) -> [String: Any] {

        let reportTypes: [ReportType] = reports.sorted { $0.identifier < $1.identifier }
        var reportsDictionary: [String: Any] = [:]

        for report in reportTypes {
            switch report {
            case .buildingsNotLinked:
                reportsDictionary[report.identifier] = buildingsNotLinked.map { $0.dictionary }
            case .categoriesNotLinked:
                reportsDictionary[report.identifier] = categoriesNotLinked.map { $0.dictionary }
            case .departmentsNotLinked:
                reportsDictionary[report.identifier] = departmentsNotLinked.map { $0.dictionary }
            case .eBooksNoScope:
                reportsDictionary[report.identifier] = eBooksNoScope.map { $0.dictionary }
            case .iBeaconsNotLinked:
                reportsDictionary[report.identifier] = iBeaconsNotLinked.map { $0.dictionary }
            case .networkSegmentsNotLinked:
                reportsDictionary[report.identifier] = networkSegmentsNotLinked.map { $0.dictionary }
            case .macAdvancedSearchesNoCriteria:
                reportsDictionary[report.identifier] = macAdvancedSearchesNoCriteria.map { $0.dictionary }
            case .macAdvancedSearchesInvalidCriteria:
                reportsDictionary[report.identifier] = macAdvancedSearchesInvalidCriteria.map { $0.dictionary }
            case .macApplicationsNoScope:
                reportsDictionary[report.identifier] = macApplicationsNoScope.map { $0.dictionary }
            case .macConfigurationProfilesNoScope:
                reportsDictionary[report.identifier] = macConfigurationProfilesNoScope.map { $0.dictionary }
            case .macDevicesDuplicateNames:
                reportsDictionary[report.identifier] = macDevicesDuplicateNames.map { $0.dictionary }
            case .macDevicesDuplicateSerialNumbers:
                reportsDictionary[report.identifier] = macDevicesDuplicateSerialNumbers.map { $0.dictionary }
            case .macDevicesLastCheckIn:
                reportsDictionary[report.identifier] = macDevicesLastCheckIn.map { $0.dictionary }
            case .macDevicesLastInventory:
                reportsDictionary[report.identifier] = macDevicesLastInventory.map { $0.dictionary }
            case .macDevicesUnmanaged:
                reportsDictionary[report.identifier] = macDevicesUnmanaged.map { $0.dictionary }
            case .macDirectoryBindingsNotLinked:
                reportsDictionary[report.identifier] = macDirectoryBindingsNotLinked.map { $0.dictionary }
            case .macDiskEncryptionsNotLinked:
                reportsDictionary[report.identifier] = macDiskEncryptionsNotLinked.map { $0.dictionary }
            case .macDockItemsNotLinked:
                reportsDictionary[report.identifier] = macDockItemsNotLinked.map { $0.dictionary }
            case .macExtensionAttributesNotLinked:
                reportsDictionary[report.identifier] = macExtensionAttributesNotLinked.map { $0.dictionary }
            case .macExtensionAttributesDisabled:
                reportsDictionary[report.identifier] = macExtensionAttributesDisabled.map { $0.dictionary }
            case .macExtensionAttributesLinterErrors:
                reportsDictionary[report.identifier] = macExtensionAttributesLinterErrors.map { $0.linterErrorsDictionary }
            case .macExtensionAttributesLinterWarnings:
                reportsDictionary[report.identifier] = macExtensionAttributesLinterWarnings.map { $0.linterWarningsDictionary }
            case .macPackagesNotLinked:
                reportsDictionary[report.identifier] = macPackagesNotLinked.map { $0.dictionary }
            case .macPoliciesNoScope:
                reportsDictionary[report.identifier] = macPoliciesNoScope.map { $0.dictionary }
            case .macPoliciesDisabled:
                reportsDictionary[report.identifier] = macPoliciesDisabled.map { $0.dictionary }
            case .macPoliciesNoPayload:
                reportsDictionary[report.identifier] = macPoliciesNoPayload.map { $0.dictionary }
            case .macPoliciesJamfRemote:
                reportsDictionary[report.identifier] = macPoliciesJamfRemote.map { $0.dictionary }
            case .macPoliciesLastExecuted:
                reportsDictionary[report.identifier] = macPoliciesLastExecuted.map { $0.dictionary }
            case .macPoliciesFailedThreshold:
                reportsDictionary[report.identifier] = macPoliciesFailedThreshold.map { $0.dictionary }
            case .macPrintersNotLinked:
                reportsDictionary[report.identifier] = macPrintersNotLinked.map { $0.dictionary }
            case .macRestrictedSoftwareNoScope:
                reportsDictionary[report.identifier] = macRestrictedSoftwaresNoScope.map { $0.dictionary }
            case .macScriptsNotLinked:
                reportsDictionary[report.identifier] = macScriptsNotLinked.map { $0.dictionary }
            case .macScriptsLinterErrors:
                reportsDictionary[report.identifier] = macScriptsLinterErrors.map { $0.linterErrorsDictionary }
            case .macScriptsLinterWarnings:
                reportsDictionary[report.identifier] = macScriptsLinterWarnings.map { $0.linterWarningsDictionary }
            case .macSmartGroupsNotLinked:
                reportsDictionary[report.identifier] = macSmartGroupsNotLinked.map { $0.dictionary }
            case .macSmartGroupsNoCriteria:
                reportsDictionary[report.identifier] = macSmartGroupsNoCriteria.map { $0.dictionary }
            case .macStaticGroupsNotLinked:
                reportsDictionary[report.identifier] = macStaticGroupsNotLinked.map { $0.dictionary }
            case .macStaticGroupsEmpty:
                reportsDictionary[report.identifier] = macStaticGroupsEmpty.map { $0.dictionary }
            case .mobileAdvancedSearchesNoCriteria:
                reportsDictionary[report.identifier] = mobileAdvancedSearchesNoCriteria.map { $0.dictionary }
            case .mobileAdvancedSearchesInvalidCriteria:
                reportsDictionary[report.identifier] = mobileAdvancedSearchesInvalidCriteria.map { $0.dictionary }
            case .mobileApplicationsNoScope:
                reportsDictionary[report.identifier] = mobileApplicationsNoScope.map { $0.dictionary }
            case .mobileConfigurationProfilesNoScope:
                reportsDictionary[report.identifier] = mobileConfigurationProfilesNoScope.map { $0.dictionary }
            case .mobileDevicesLastInventory:
                reportsDictionary[report.identifier] = mobileDevicesLastInventory.map { $0.dictionary }
            case .mobileDevicesUnmanaged:
                reportsDictionary[report.identifier] = mobileDevicesUnmanaged.map { $0.dictionary }
            case .mobileExtensionAttributesNotLinked:
                reportsDictionary[report.identifier] = mobileExtensionAttributesNotLinked.map { $0.dictionary }
            case .mobileSmartGroupsNotLinked:
                reportsDictionary[report.identifier] = mobileSmartGroupsNotLinked.map { $0.dictionary }
            case .mobileSmartGroupsNoCriteria:
                reportsDictionary[report.identifier] = mobileSmartGroupsNoCriteria.map { $0.dictionary }
            case .mobileStaticGroupsNotLinked:
                reportsDictionary[report.identifier] = mobileStaticGroupsNotLinked.map { $0.dictionary }
            case .mobileStaticGroupsEmpty:
                reportsDictionary[report.identifier] = mobileStaticGroupsEmpty.map { $0.dictionary }
            }
        }

        return ["name": configuration.name, "url": configuration.url, "reports": reportsDictionary]
    }

    // swiftlint:enable cyclomatic_complexity
    // swiftlint:enable function_body_length

    /// Save the generated reports to disk based on the provided configuration.
    ///
    /// - Parameters:
    ///   - configuration: The configuration used to generate the report data.
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
                PrettyPrint.print(error.localizedDescription, prefixColor: .red)
            }
        }
    }

    /// Generate a data blob for the generated reports.
    ///
    /// - Parameters:
    ///   - type:          The `OutputType` (format) the data should be created as.
    ///   - configuration: The configuration used to generate the report data.
    /// - Returns: Data if successful, otherwise `nil`.
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
            PrettyPrint.print(error.localizedDescription, prefixColor: .red)
        }

        return nil
    }
}
