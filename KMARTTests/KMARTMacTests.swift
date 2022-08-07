//
//  KMARTMacTests.swift
//  KMARTTests
//
//  Created by Nindi Gill on 24/2/21.
//

import XCTest

// swiftlint:disable file_length
// swiftlint:disable:next type_body_length
class KMARTMacTests: XCTestCase {

    func testMacAdvancedSearchesCriteria() throws {
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1)]
        let results: [MacAdvancedSearch] = Reporter.macAdvancedSearchesNoCriteria(macAdvancedSearches)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacAdvancedSearchesNoCriteria() throws {
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: [Criterion(name: "Name", type: "member of", value: "Value")])]
        let results: [MacAdvancedSearch] = Reporter.macAdvancedSearchesNoCriteria(macAdvancedSearches)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacAdvancedSearchesValidCriteria() throws {
        let criteria: [Criterion] = [Criterion(name: "Computer Group", type: "member of", value: "Smart Group"), Criterion(name: "Computer Group", type: "member of", value: "Static Group")]
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: criteria)]
        let macSmartGroups: [SmartGroup] = [SmartGroup(id: 1, name: "Smart Group")]
        let macStaticGroups: [StaticGroup] = [StaticGroup(id: 2, name: "Static Group")]
        let objects: Objects = Objects(macAdvancedSearches: macAdvancedSearches, macSmartGroups: macSmartGroups, macStaticGroups: macStaticGroups)
        let results: [MacAdvancedSearch] = Reporter.macAdvancedSearchesInvalidCriteria(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacAdvancedSearchesInvalidCriteria() throws {
        let criteria: [Criterion] = [Criterion(name: "Computer Group", type: "member of", value: "Incorrect Smart Group"), Criterion(name: "Computer Group", type: "member of", value: "Incorrect Static Group")]
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: criteria)]
        let macSmartGroups: [SmartGroup] = [SmartGroup(id: 1, name: "Smart Group")]
        let macStaticGroups: [StaticGroup] = [StaticGroup(id: 2, name: "Static Group")]
        let objects: Objects = Objects(macAdvancedSearches: macAdvancedSearches, macSmartGroups: macSmartGroups, macStaticGroups: macStaticGroups)
        let results: [MacAdvancedSearch] = Reporter.macAdvancedSearchesInvalidCriteria(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacApplicationsScopeTargets() throws {
        let macApplications: [MacApplication] = [
            MacApplication(id: 1, macTargets: MacTargets(allDevices: true)),
            MacApplication(id: 2, macTargets: MacTargets(buildings: [1])),
            MacApplication(id: 3, macTargets: MacTargets(departments: [1])),
            MacApplication(id: 4, macTargets: MacTargets(devices: [1])),
            MacApplication(id: 5, macTargets: MacTargets(deviceGroups: [1])),
            MacApplication(id: 6, macExclusions: MacExclusions(buildings: [1])),
            MacApplication(id: 7, macExclusions: MacExclusions(departments: [1])),
            MacApplication(id: 8, macExclusions: MacExclusions(devices: [1])),
            MacApplication(id: 9, macExclusions: MacExclusions(deviceGroups: [1])),
            MacApplication(id: 10, macExclusions: MacExclusions(users: ["User"])),
            MacApplication(id: 11, macExclusions: MacExclusions(userGroups: ["User Group"])),
            MacApplication(id: 12, macExclusions: MacExclusions(networkSegments: [1])),
            MacApplication(id: 13, macExclusions: MacExclusions(iBeacons: [1])),
            MacApplication(id: 14, limitations: Limitations(users: ["User"])),
            MacApplication(id: 15, limitations: Limitations(userGroups: ["User Group"])),
            MacApplication(id: 16, limitations: Limitations(networkSegments: [1])),
            MacApplication(id: 17, limitations: Limitations(iBeacons: [1]))
        ]
        let results: [MacApplication] = Reporter.macApplicationsNoScope(macApplications)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacApplicationsNoScope() throws {
        let macApplications: [MacApplication] = [MacApplication(id: 1)]
        let results: [MacApplication] = Reporter.macApplicationsNoScope(macApplications)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacConfigurationProfilesScope() throws {
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macTargets: MacTargets(allDevices: true)),
            MacConfigurationProfile(id: 2, macTargets: MacTargets(buildings: [1])),
            MacConfigurationProfile(id: 3, macTargets: MacTargets(departments: [1])),
            MacConfigurationProfile(id: 4, macTargets: MacTargets(devices: [1])),
            MacConfigurationProfile(id: 5, macTargets: MacTargets(deviceGroups: [1])),
            MacConfigurationProfile(id: 6, macExclusions: MacExclusions(buildings: [1])),
            MacConfigurationProfile(id: 7, macExclusions: MacExclusions(departments: [1])),
            MacConfigurationProfile(id: 8, macExclusions: MacExclusions(devices: [1])),
            MacConfigurationProfile(id: 9, macExclusions: MacExclusions(deviceGroups: [1])),
            MacConfigurationProfile(id: 10, macExclusions: MacExclusions(users: ["User"])),
            MacConfigurationProfile(id: 11, macExclusions: MacExclusions(userGroups: ["User Group"])),
            MacConfigurationProfile(id: 12, macExclusions: MacExclusions(networkSegments: [1])),
            MacConfigurationProfile(id: 13, macExclusions: MacExclusions(iBeacons: [1])),
            MacConfigurationProfile(id: 14, limitations: Limitations(users: ["User"])),
            MacConfigurationProfile(id: 15, limitations: Limitations(userGroups: ["User Group"])),
            MacConfigurationProfile(id: 16, limitations: Limitations(networkSegments: [1])),
            MacConfigurationProfile(id: 17, limitations: Limitations(iBeacons: [1]))
        ]
        let results: [MacConfigurationProfile] = Reporter.macConfigurationProfilesNoScope(macConfigurationProfiles)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacConfigurationProfilesNoScope() throws {
        let macConfigurationProfiles: [MacConfigurationProfile] = [MacConfigurationProfile(id: 1)]
        let results: [MacConfigurationProfile] = Reporter.macConfigurationProfilesNoScope(macConfigurationProfiles)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacDevicesDuplicateNames() throws {
        let macDevices: [MacDevice] = [
            MacDevice(id: 1, name: "Name"),
            MacDevice(id: 2, name: "Name")
        ]
        let results: [MacDevice] = Reporter.macDevicesDuplicateNames(macDevices)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacDevicesNoDuplicateNames() throws {
        let macDevices: [MacDevice] = [
            MacDevice(id: 1, name: "Unique Name #1"),
            MacDevice(id: 2, name: "Unique Name #2")
        ]
        let results: [MacDevice] = Reporter.macDevicesDuplicateNames(macDevices)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacDevicesDuplicateSerialNumbers() throws {
        let macDevices: [MacDevice] = [
            MacDevice(id: 1, serialNumber: "Serial Number"),
            MacDevice(id: 2, serialNumber: "Serial Number")
        ]
        let results: [MacDevice] = Reporter.macDevicesDuplicateSerialNumbers(macDevices)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacDevicesNoDuplicateSerialNumbers() throws {
        let macDevices: [MacDevice] = [
            MacDevice(id: 1, serialNumber: "Unique Serial Number #1"),
            MacDevice(id: 2, serialNumber: "Unique Serial Number #2")
        ]
        let results: [MacDevice] = Reporter.macDevicesDuplicateSerialNumbers(macDevices)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacDevicesLastCheckIn30Days() throws {
        let date: Date = Date()

        guard let fifteenDays: Date = Calendar.current.date(byAdding: .day, value: -15, to: date),
            let thirtyDays: Date = Calendar.current.date(byAdding: .day, value: -30, to: date),
            let fortyFiveDays: Date = Calendar.current.date(byAdding: .day, value: -45, to: date) else {
            return
        }

        let macDevices: [MacDevice] = [
            MacDevice(id: 1, lastCheckIn: fifteenDays.timeIntervalSince1970, managed: true),
            MacDevice(id: 2, lastCheckIn: thirtyDays.timeIntervalSince1970, managed: true),
            MacDevice(id: 3, lastCheckIn: fortyFiveDays.timeIntervalSince1970, managed: true),
            MacDevice(id: 4, lastCheckIn: fifteenDays.timeIntervalSince1970, managed: false),
            MacDevice(id: 5, lastCheckIn: thirtyDays.timeIntervalSince1970, managed: false),
            MacDevice(id: 6, lastCheckIn: fortyFiveDays.timeIntervalSince1970, managed: false)
        ]
        let options: [ReportOptionType: Int] = [.macDevicesLastCheckIn: 30]
        let results: [MacDevice] = Reporter.macDevicesLastCheckIn(macDevices, options: options)
        XCTAssertTrue(results.count == 2)
        XCTAssertTrue(results[0].id == 2)
        XCTAssertTrue(results[1].id == 3)
    }

    func testMacDevicesLastInventory30Days() throws {
        let date: Date = Date()

        guard let fifteenDays: Date = Calendar.current.date(byAdding: .day, value: -15, to: date),
            let thirtyDays: Date = Calendar.current.date(byAdding: .day, value: -30, to: date),
            let fortyFiveDays: Date = Calendar.current.date(byAdding: .day, value: -45, to: date) else {
            return
        }

        let macDevices: [MacDevice] = [
            MacDevice(id: 1, lastInventory: fifteenDays.timeIntervalSince1970, managed: true),
            MacDevice(id: 2, lastInventory: thirtyDays.timeIntervalSince1970, managed: true),
            MacDevice(id: 3, lastInventory: fortyFiveDays.timeIntervalSince1970, managed: true),
            MacDevice(id: 4, lastInventory: fifteenDays.timeIntervalSince1970, managed: false),
            MacDevice(id: 5, lastInventory: thirtyDays.timeIntervalSince1970, managed: false),
            MacDevice(id: 6, lastInventory: fortyFiveDays.timeIntervalSince1970, managed: false)
        ]
        let options: [ReportOptionType: Int] = [.macDevicesLastInventory: 30]
        let results: [MacDevice] = Reporter.macDevicesLastInventory(macDevices, options: options)
        XCTAssertTrue(results.count == 2)
        XCTAssertTrue(results[0].id == 2)
        XCTAssertTrue(results[1].id == 3)
    }

    func testMacDevicesManaged() throws {
        let macDevices: [MacDevice] = [
            MacDevice(id: 1, managed: true),
            MacDevice(id: 2, managed: true)
        ]
        let results: [MacDevice] = Reporter.macDevicesUnmanaged(macDevices)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacDevicesUnmanaged() throws {
        let macDevices: [MacDevice] = [
            MacDevice(id: 1, managed: false),
            MacDevice(id: 2, managed: false)
        ]
        let results: [MacDevice] = Reporter.macDevicesUnmanaged(macDevices)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacDirectoryBindingsLinked() throws {
        let macDirectoryBindings: [MacDirectoryBinding] = [MacDirectoryBinding(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, directoryBindings: [1])]
        let objects: Objects = Objects(macDirectoryBindings: macDirectoryBindings, macPolicies: macPolicies)
        let results: [MacDirectoryBinding] = Reporter.macDirectoryBindingsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacDirectoryBindingsNotLinked() throws {
        let macDirectoryBindings: [MacDirectoryBinding] = [MacDirectoryBinding(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, directoryBindings: [2])]
        let objects: Objects = Objects(macDirectoryBindings: macDirectoryBindings, macPolicies: macPolicies)
        let results: [MacDirectoryBinding] = Reporter.macDirectoryBindingsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacDiskEncryptionsLinked() throws {
        let macDiskEncryptions: [MacDiskEncryption] = [MacDiskEncryption(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, diskEncryption: 1)]
        let objects: Objects = Objects(macDiskEncryptions: macDiskEncryptions, macPolicies: macPolicies)
        let results: [MacDiskEncryption] = Reporter.macDiskEncryptionsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacDiskEncryptionsNotLinked() throws {
        let macDiskEncryptions: [MacDiskEncryption] = [MacDiskEncryption(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, diskEncryption: 2)]
        let objects: Objects = Objects(macDiskEncryptions: macDiskEncryptions, macPolicies: macPolicies)
        let results: [MacDiskEncryption] = Reporter.macDiskEncryptionsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacDockItemsLinked() throws {
        let macDockItems: [MacDockItem] = [MacDockItem(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, dockItems: [1])]
        let objects: Objects = Objects(macDockItems: macDockItems, macPolicies: macPolicies)
        let results: [MacDockItem] = Reporter.macDockItemsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacDockItemsNotLinked() throws {
        let macDockItems: [MacDockItem] = [MacDockItem(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, dockItems: [2])]
        let objects: Objects = Objects(macDockItems: macDockItems, macPolicies: macPolicies)
        let results: [MacDockItem] = Reporter.macDockItemsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacExtensionAttributesLinked() throws {
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: [Criterion(name: "Name")])]
        let macExtensionAttributes: [MacExtensionAttribute] = [MacExtensionAttribute(id: 1, name: "Name")]
        let macSmartGroups: [SmartGroup] = [SmartGroup(id: 1, criteria: [Criterion(name: "Name")])]
        let objects: Objects = Objects(macAdvancedSearches: macAdvancedSearches, macExtensionAttributes: macExtensionAttributes, macSmartGroups: macSmartGroups)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacExtensionAttributesNotLinked() throws {
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: [Criterion()])]
        let macExtensionAttributes: [MacExtensionAttribute] = [MacExtensionAttribute(id: 1, name: "Name")]
        let macSmartGroups: [SmartGroup] = [SmartGroup(id: 1, criteria: [Criterion()])]
        let objects: Objects = Objects(macAdvancedSearches: macAdvancedSearches, macExtensionAttributes: macExtensionAttributes, macSmartGroups: macSmartGroups)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacExtensionAttributesEnabled() throws {
        let macExtensionAttributeScript: MacExtensionAttribute = MacExtensionAttribute(id: 1, enabled: true, inputType: "Script")
        let macExtensionAttributeLDAP: MacExtensionAttribute = MacExtensionAttribute(id: 2, enabled: true, inputType: "LDAP")
        let macExtensionAttributes: [MacExtensionAttribute] = [macExtensionAttributeScript, macExtensionAttributeLDAP]
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesDisabled(macExtensionAttributes)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacExtensionAttributesDisabled() throws {
        let macExtensionAttributeScript: MacExtensionAttribute = MacExtensionAttribute(id: 1, enabled: false, inputType: "Script")
        let macExtensionAttributeLDAP: MacExtensionAttribute = MacExtensionAttribute(id: 2, enabled: false, inputType: "LDAP")
        let macExtensionAttributes: [MacExtensionAttribute] = [macExtensionAttributeScript, macExtensionAttributeLDAP]
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesDisabled(macExtensionAttributes)
        XCTAssertEqual(results.count, 1)
    }

    func testMacExtensionAttributesShellNoLinterErrors() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1008
        let script: String = """
        #!/bin/mywrapper
        # shellcheck shell=bash

        echo "Hello World!"

        exit 0

        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterErrors([macExtensionAttribute])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacExtensionAttributesShellLinterErrors() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1008
        let script: String = """
        #!/bin/mywrapper

        echo "Hello World!"

        exit 0

        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterErrors([macExtensionAttribute])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacExtensionAttributesShellNoLinterWarnings() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1015
        let script: String = """
        #!/usr/bin/env bash

        echo "Hello World!"

        exit 0

        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterWarnings([macExtensionAttribute])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacExtensionAttributesShellLinterWarnings() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1015
        let script: String = """
        #!/usr/bin/env bash

        echo “Hello World!”

        exit 0

        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterWarnings([macExtensionAttribute])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacExtensionAttributesPythonNoLinterErrors() throws {
        // https://flake8.pycqa.org/en/4.0.1/user/error-codes.html
        let script: String = """
        #!/usr/bin/env python3

        print("Hello World!")

        exit(0)

        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterErrors([macExtensionAttribute])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacExtensionAttributesPythonLinterErrors() throws {
        // https://flake8.pycqa.org/en/4.0.1/user/error-codes.html
        let script: String = """
        #!/usr/bin/env python3

        import json

        print("Hello World!")

        exit(0)

        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterErrors([macExtensionAttribute])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacExtensionAttributesPythonNoLinterWarnings() throws {
        // https://flake8.pycqa.org/en/4.0.1/user/error-codes.html
        let script: String = """
        #!/usr/bin/env python3

        print("Hello World!")

        exit(0)

        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterWarnings([macExtensionAttribute])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacExtensionAttributesPythonLinterWarnings() throws {
        // https://flake8.pycqa.org/en/4.0.1/user/error-codes.html
        let script: String = """
        #!/usr/bin/env python3

        print("Hello World!")

        exit(0)
        """
        let macExtensionAttribute: MacExtensionAttribute = MacExtensionAttribute(id: 1, inputType: "script", scriptContents: script)
        let results: [MacExtensionAttribute] = Reporter.macExtensionAttributesLinterWarnings([macExtensionAttribute])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPackagesLinked() throws {
        let macPackages: [MacPackage] = [MacPackage(id: 1)]
        let macPatchSoftwareTitles: [MacPatchSoftwareTitle] = [MacPatchSoftwareTitle(id: 1, packages: [1])]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, packages: [1])]
        let objects: Objects = Objects(macPackages: macPackages, macPatchSoftwareTitles: macPatchSoftwareTitles, macPolicies: macPolicies)
        let results: [MacPackage] = Reporter.macPackagesNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPackagesNotLinked() throws {
        let macPackages: [MacPackage] = [MacPackage(id: 1), MacPackage(id: 2)]
        let macPatchSoftwareTitles: [MacPatchSoftwareTitle] = [MacPatchSoftwareTitle(id: 1, packages: [1])]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, packages: [1])]
        let objects: Objects = Objects(macPackages: macPackages, macPatchSoftwareTitles: macPatchSoftwareTitles, macPolicies: macPolicies)
        let results: [MacPackage] = Reporter.macPackagesNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPatchPolicyScope() throws {
        let macPatchPolicies: [MacPatchPolicy] = [
            MacPatchPolicy(id: 1, macTargets: MacTargets(allDevices: true)),
            MacPatchPolicy(id: 2, macTargets: MacTargets(buildings: [1])),
            MacPatchPolicy(id: 3, macTargets: MacTargets(departments: [1])),
            MacPatchPolicy(id: 4, macTargets: MacTargets(devices: [1])),
            MacPatchPolicy(id: 5, macTargets: MacTargets(deviceGroups: [1])),
            MacPatchPolicy(id: 6, macExclusions: MacExclusions(buildings: [1])),
            MacPatchPolicy(id: 7, macExclusions: MacExclusions(departments: [1])),
            MacPatchPolicy(id: 8, macExclusions: MacExclusions(devices: [1])),
            MacPatchPolicy(id: 9, macExclusions: MacExclusions(deviceGroups: [1])),
            MacPatchPolicy(id: 10, macExclusions: MacExclusions(users: ["User"])),
            MacPatchPolicy(id: 11, macExclusions: MacExclusions(userGroups: ["User Group"])),
            MacPatchPolicy(id: 12, macExclusions: MacExclusions(networkSegments: [1])),
            MacPatchPolicy(id: 13, macExclusions: MacExclusions(iBeacons: [1])),
            MacPatchPolicy(id: 14, limitations: Limitations(users: ["User"])),
            MacPatchPolicy(id: 15, limitations: Limitations(userGroups: ["User Group"])),
            MacPatchPolicy(id: 16, limitations: Limitations(networkSegments: [1])),
            MacPatchPolicy(id: 17, limitations: Limitations(iBeacons: [1]))
        ]
        let results: [MacPatchPolicy] = Reporter.macPatchPoliciesNoScope(macPatchPolicies)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPatchPolicyNoScope() throws {
        let macPatchPolicies: [MacPatchPolicy] = [MacPatchPolicy(id: 1)]
        let results: [MacPatchPolicy] = Reporter.macPatchPoliciesNoScope(macPatchPolicies)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPatchPoliciesEnabled() throws {
        let macPatchPolicies: [MacPatchPolicy] = [MacPatchPolicy(id: 1, enabled: true)]
        let results: [MacPatchPolicy] = Reporter.macPatchPoliciesDisabled(macPatchPolicies)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPatchPoliciesDisabled() throws {
        let macPatchPolicies: [MacPatchPolicy] = [MacPatchPolicy(id: 1)]
        let results: [MacPatchPolicy] = Reporter.macPatchPoliciesDisabled(macPatchPolicies)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPolicyScope() throws {
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macTargets: MacTargets(allDevices: true)),
            MacPolicy(id: 2, macTargets: MacTargets(buildings: [1])),
            MacPolicy(id: 3, macTargets: MacTargets(departments: [1])),
            MacPolicy(id: 4, macTargets: MacTargets(devices: [1])),
            MacPolicy(id: 5, macTargets: MacTargets(deviceGroups: [1])),
            MacPolicy(id: 6, macExclusions: MacExclusions(buildings: [1])),
            MacPolicy(id: 7, macExclusions: MacExclusions(departments: [1])),
            MacPolicy(id: 8, macExclusions: MacExclusions(devices: [1])),
            MacPolicy(id: 9, macExclusions: MacExclusions(deviceGroups: [1])),
            MacPolicy(id: 10, macExclusions: MacExclusions(users: ["User"])),
            MacPolicy(id: 11, macExclusions: MacExclusions(userGroups: ["User Group"])),
            MacPolicy(id: 12, macExclusions: MacExclusions(networkSegments: [1])),
            MacPolicy(id: 13, macExclusions: MacExclusions(iBeacons: [1])),
            MacPolicy(id: 14, limitations: Limitations(users: ["User"])),
            MacPolicy(id: 15, limitations: Limitations(userGroups: ["User Group"])),
            MacPolicy(id: 16, limitations: Limitations(networkSegments: [1])),
            MacPolicy(id: 17, limitations: Limitations(iBeacons: [1]))
        ]
        let results: [MacPolicy] = Reporter.macPoliciesNoScope(macPolicies)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPolicyNoScope() throws {
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1)]
        let results: [MacPolicy] = Reporter.macPoliciesNoScope(macPolicies)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPoliciesEnabled() throws {
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, enabled: true)]
        let results: [MacPolicy] = Reporter.macPoliciesDisabled(macPolicies)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPoliciesDisabled() throws {
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1)]
        let results: [MacPolicy] = Reporter.macPoliciesDisabled(macPolicies)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPoliciesPayload() throws {
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, diskEncryption: 1),
            MacPolicy(id: 2, directoryBindings: [1]),
            MacPolicy(id: 3, dockItems: [1]),
            MacPolicy(id: 4, packages: [1]),
            MacPolicy(id: 5, printers: [1]),
            MacPolicy(id: 6, scripts: [1]),
            MacPolicy(id: 7, accounts: true),
            MacPolicy(id: 8, filesProcesses: true),
            MacPolicy(id: 9, maintenance: true),
            MacPolicy(id: 10, managementAccount: true),
            MacPolicy(id: 11, restart: true),
            MacPolicy(id: 12, softwareUpdates: true)
        ]
        let results: [MacPolicy] = Reporter.macPoliciesNoPayload(macPolicies)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPoliciesNoPayload() throws {
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1)]
        let results: [MacPolicy] = Reporter.macPoliciesNoPayload(macPolicies)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPoliciesNotJamfRemote() throws {
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, name: "Test Policy")]
        let results: [MacPolicy] = Reporter.macPoliciesJamfRemote(macPolicies)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPoliciesJamfRemote() throws {
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, name: "2021-04-20 at 04:20 PM | ninxsoft | 420 Computers")]
        let results: [MacPolicy] = Reporter.macPoliciesJamfRemote(macPolicies)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacPoliciesLastExecuted30Days() throws {
        let date: Date = Date()

        guard let fifteenDays: Date = Calendar.current.date(byAdding: .day, value: -15, to: date),
            let thirtyDays: Date = Calendar.current.date(byAdding: .day, value: -30, to: date),
            let fortyFiveDays: Date = Calendar.current.date(byAdding: .day, value: -45, to: date) else {
            return
        }

        let macDevicesHistory: [MacDeviceHistory] = [
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 1, date: fifteenDays.timeIntervalSince1970)]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 2, date: thirtyDays.timeIntervalSince1970)]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 3, date: fortyFiveDays.timeIntervalSince1970)])
        ]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1), MacPolicy(id: 2), MacPolicy(id: 3)]
        let objects: Objects = Objects(macDevicesHistory: macDevicesHistory, macPolicies: macPolicies)
        let options: [ReportOptionType: Int] = [.macPoliciesLastExecuted: 30]
        let results: [MacPolicy] = Reporter.macPoliciesLastExecuted(objects, options: options)
        XCTAssertTrue(results.count == 2)
        XCTAssertTrue(results[0].id == 2)
        XCTAssertTrue(results[1].id == 3)
    }

    func testMacPoliciesFailedThreshold20Percent() throws {
        let macDevicesHistory: [MacDeviceHistory] = [
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 1, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 1, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 1, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 1, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 1, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 2, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 2, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 2, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 2, status: "Success")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 2, status: "Failed")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 3, status: "Failed")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 3, status: "Failed")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 3, status: "Failed")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 3, status: "Failed")]),
            MacDeviceHistory(id: 1, macPolicyLogs: [MacPolicyLog(id: 3, status: "Failed")])
        ]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1), MacPolicy(id: 2), MacPolicy(id: 3)]
        let objects: Objects = Objects(macDevicesHistory: macDevicesHistory, macPolicies: macPolicies)
        let options: [ReportOptionType: Int] = [.macPoliciesFailedThreshold: 20]
        let results: [MacPolicy] = Reporter.macPoliciesFailedThreshold(objects, options: options)
        XCTAssertTrue(results.count == 2)
        XCTAssertTrue(results[0].id == 2)
        XCTAssertTrue(results[1].id == 3)
    }

    func testMacPrintersLinked() throws {
        let macPrinters: [MacPrinter] = [MacPrinter(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, printers: [1])]
        let objects: Objects = Objects(macPolicies: macPolicies, macPrinters: macPrinters)
        let results: [MacPrinter] = Reporter.macPrintersNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacPrintersNotLinked() throws {
        let macPrinters: [MacPrinter] = [MacPrinter(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, printers: [2])]
        let objects: Objects = Objects(macPolicies: macPolicies, macPrinters: macPrinters)
        let results: [MacPrinter] = Reporter.macPrintersNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacRestrictedSoftwareScope() throws {
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [
            MacRestrictedSoftware(id: 1, macTargets: MacTargets(allDevices: true)),
            MacRestrictedSoftware(id: 2, macTargets: MacTargets(buildings: [1])),
            MacRestrictedSoftware(id: 3, macTargets: MacTargets(departments: [1])),
            MacRestrictedSoftware(id: 4, macTargets: MacTargets(devices: [1])),
            MacRestrictedSoftware(id: 5, macTargets: MacTargets(deviceGroups: [1])),
            MacRestrictedSoftware(id: 6, macExclusions: MacExclusions(buildings: [1])),
            MacRestrictedSoftware(id: 7, macExclusions: MacExclusions(departments: [1])),
            MacRestrictedSoftware(id: 8, macExclusions: MacExclusions(devices: [1])),
            MacRestrictedSoftware(id: 9, macExclusions: MacExclusions(deviceGroups: [1])),
            MacRestrictedSoftware(id: 10, macExclusions: MacExclusions(users: ["User"])),
            MacRestrictedSoftware(id: 11, macExclusions: MacExclusions(userGroups: ["User Group"])),
            MacRestrictedSoftware(id: 12, macExclusions: MacExclusions(networkSegments: [1])),
            MacRestrictedSoftware(id: 13, macExclusions: MacExclusions(iBeacons: [1]))
        ]
        let results: [MacRestrictedSoftware] = Reporter.macRestrictedSoftwaresNoScope(macRestrictedSoftwares)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacRestrictedSoftwaresNoScope() throws {
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [MacRestrictedSoftware(id: 1)]
        let results: [MacRestrictedSoftware] = Reporter.macRestrictedSoftwaresNoScope(macRestrictedSoftwares)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacScriptsLinked() throws {
        let macScripts: [MacScript] = [MacScript(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, scripts: [1])]
        let objects: Objects = Objects(macPolicies: macPolicies, macScripts: macScripts)
        let results: [MacScript] = Reporter.macScriptsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacScriptsNotLinked() throws {
        let macScripts: [MacScript] = [MacScript(id: 1)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, scripts: [2])]
        let objects: Objects = Objects(macPolicies: macPolicies, macScripts: macScripts)
        let results: [MacScript] = Reporter.macScriptsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacScriptsShellNoLinterErrors() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1008
        let script: String = """
        #!/bin/mywrapper
        # shellcheck shell=bash

        echo "Hello World!"

        exit 0

        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterErrors([macScript])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacScriptsShellLinterErrors() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1008
        let script: String = """
        #!/bin/mywrapper

        echo "Hello World!"

        exit 0

        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterErrors([macScript])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacScriptsShellNoLinterWarnings() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1015
        let script: String = """
        #!/usr/bin/env bash

        echo "Hello World!"

        exit 0

        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterWarnings([macScript])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacScriptsShellLinterWarnings() throws {
        // https://github.com/koalaman/shellcheck/wiki/SC1015
        let script: String = """
        #!/usr/bin/env bash

        echo “Hello World!”

        exit 0

        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterWarnings([macScript])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacScriptsPythonNoLinterErrors() throws {
        // https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
        let script: String = """
        #!/usr/bin/env python3

        print("Hello World!")

        exit(0)

        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterErrors([macScript])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacScriptsPythonLinterErrors() throws {
        // https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
        let script: String = """
        #!/usr/bin/env python3

        import json

        print("Hello World!")

        exit(0)

        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterErrors([macScript])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacScriptsPythonNoLinterWarnings() throws {
        // https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
        let script: String = """
        #!/usr/bin/env python3

        print("Hello World!")

        exit(0)

        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterWarnings([macScript])
        XCTAssertTrue(results.isEmpty)
    }

    func testMacScriptsPythonLinterWarnings() throws {
        // https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
        let script: String = """
        #!/usr/bin/env python3

        print("Hello World!")

        exit(0)
        """
        let macScript: MacScript = MacScript(id: 1, scriptContents: script)
        let results: [MacScript] = Reporter.macScriptsLinterWarnings([macScript])
        XCTAssertFalse(results.isEmpty)
    }

    func testMacSmartGroupsLinked() throws {
        let macTargets: MacTargets = MacTargets(deviceGroups: [1])
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: [Criterion(name: "Computer Group", type: "member of", value: "Unique Smart Group #1")])]
        let macApplications: [MacApplication] = [MacApplication(id: 1, macTargets: macTargets)]
        let macConfigurationProfiles: [MacConfigurationProfile] = [MacConfigurationProfile(id: 1, macTargets: macTargets)]
        let macPatchPolicies: [MacPatchPolicy] = [MacPatchPolicy(id: 1, macTargets: macTargets)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, macTargets: macTargets)]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [MacRestrictedSoftware(id: 1, macTargets: macTargets)]
        let macSmartGroups: [SmartGroup] = [
            SmartGroup(id: 1, name: "Unique Smart Group #1"),
            SmartGroup(id: 2, name: "Unique Smart Group #2", criteria: [Criterion(name: "Computer Group", type: "member of", value: "Unique Smart Group #3")]),
            SmartGroup(id: 3, name: "Unique Smart Group #3", criteria: [Criterion(name: "Computer Group", type: "member of", value: "Unique Smart Group #2")])
        ]
        let objects: Objects = Objects(
            macAdvancedSearches: macAdvancedSearches,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPatchPolicies: macPatchPolicies,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            macSmartGroups: macSmartGroups
        )
        let results: [SmartGroup] = Reporter.macSmartGroupsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacSmartGroupsNotLinked() throws {
        let macTargets: MacTargets = MacTargets(deviceGroups: [1])
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: [Criterion(name: "Computer Group", type: "member of", value: "Unique Smart Group #1")])]
        let macApplications: [MacApplication] = [MacApplication(id: 1, macTargets: macTargets)]
        let macConfigurationProfiles: [MacConfigurationProfile] = [MacConfigurationProfile(id: 1, macTargets: macTargets)]
        let macPatchPolicies: [MacPatchPolicy] = [MacPatchPolicy(id: 1, macTargets: macTargets)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, macTargets: macTargets)]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [MacRestrictedSoftware(id: 1, macTargets: macTargets)]
        let macSmartGroups: [SmartGroup] = [
            SmartGroup(id: 1, name: "Unique Smart Group #1"),
            SmartGroup(id: 2, name: "Unique Smart Group #2", criteria: [Criterion(name: "Computer Group", type: "member of", value: "Unique Smart Group #1")]),
            SmartGroup(id: 3, name: "Unique Smart Group #3")
        ]
        let objects: Objects = Objects(
            macAdvancedSearches: macAdvancedSearches,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPatchPolicies: macPatchPolicies,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            macSmartGroups: macSmartGroups
        )
        let results: [SmartGroup] = Reporter.macSmartGroupsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacSmartGroupsCriteria() throws {
        let macSmartGroups: [SmartGroup] = [SmartGroup(id: 1)]
        let results: [SmartGroup] = Reporter.macSmartGroupsNoCriteria(macSmartGroups)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacSmartGroupsNoCriteria() throws {
        let macSmartGroups: [SmartGroup] = [SmartGroup(id: 1, criteria: [Criterion(name: "Name", type: "member of", value: "Value")])]
        let results: [SmartGroup] = Reporter.macSmartGroupsNoCriteria(macSmartGroups)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacStaticGroupsLinked() throws {
        let macTargets: MacTargets = MacTargets(deviceGroups: [1])
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: [Criterion(name: "Computer Group", type: "member of", value: "Static Group")])]
        let macApplications: [MacApplication] = [MacApplication(id: 1, macTargets: macTargets)]
        let macConfigurationProfiles: [MacConfigurationProfile] = [MacConfigurationProfile(id: 1, macTargets: macTargets)]
        let macPatchPolicies: [MacPatchPolicy] = [MacPatchPolicy(id: 1, macTargets: macTargets)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, macTargets: macTargets)]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [MacRestrictedSoftware(id: 1, macTargets: macTargets)]
        let macStaticGroups: [StaticGroup] = [StaticGroup(id: 1, name: "Static Group")]
        let objects: Objects = Objects(
            macAdvancedSearches: macAdvancedSearches,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPatchPolicies: macPatchPolicies,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            macStaticGroups: macStaticGroups
        )
        let results: [StaticGroup] = Reporter.macStaticGroupsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacStaticGroupsNotLinked() throws {
        let macTargets: MacTargets = MacTargets(deviceGroups: [2])
        let macAdvancedSearches: [MacAdvancedSearch] = [MacAdvancedSearch(id: 1, criteria: [Criterion(name: "Computer Group", type: "member of", value: "Unique Static Group #2")])]
        let macApplications: [MacApplication] = [MacApplication(id: 1, macTargets: macTargets)]
        let macConfigurationProfiles: [MacConfigurationProfile] = [MacConfigurationProfile(id: 1, macTargets: macTargets)]
        let macPatchPolicies: [MacPatchPolicy] = [MacPatchPolicy(id: 1, macTargets: macTargets)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, macTargets: macTargets)]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [MacRestrictedSoftware(id: 1, macTargets: macTargets)]
        let macStaticGroups: [StaticGroup] = [StaticGroup(id: 1, name: "Unique Static Group #1")]
        let objects: Objects = Objects(
            macAdvancedSearches: macAdvancedSearches,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPatchPolicies: macPatchPolicies,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            macStaticGroups: macStaticGroups
        )
        let results: [StaticGroup] = Reporter.macStaticGroupsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMacStaticGroupsNotEmpty() throws {
        let macStaticGroups: [StaticGroup] = [StaticGroup(id: 1, devices: [1])]
        let results: [StaticGroup] = Reporter.macStaticGroupsEmpty(macStaticGroups)
        XCTAssertTrue(results.isEmpty)
    }

    func testMacStaticGroupsEmpty() throws {
        let macStaticGroups: [StaticGroup] = [StaticGroup(id: 1)]
        let results: [StaticGroup] = Reporter.macStaticGroupsEmpty(macStaticGroups)
        XCTAssertFalse(results.isEmpty)
    }
}
