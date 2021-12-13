//
//  KMARTMobileTests.swift
//  KMARTTests
//
//  Created by Nindi Gill on 28/2/21.
//

import XCTest

class KMARTMobileTests: XCTestCase {

    func testMobileAdvancedSearchesCriteria() throws {
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1)]
        let results: [MobileAdvancedSearch] = Reporter.mobileAdvancedSearchesNoCriteria(mobileAdvancedSearches)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileAdvancedSearchesNoCriteria() throws {
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: [Criterion(name: "Name", type: "Type", value: "Value")])]
        let results: [MobileAdvancedSearch] = Reporter.mobileAdvancedSearchesNoCriteria(mobileAdvancedSearches)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileAdvancedSearchesValidCriteria() throws {
        let criteria: [Criterion] = [Criterion(name: "Mobile Device Group", value: "Smart Group"), Criterion(name: "Mobile Device Group", value: "Static Group")]
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: criteria)]
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1, name: "Smart Group")]
        let mobileStaticGroups: [StaticGroup] = [StaticGroup(id: 2, name: "Static Group")]
        let objects: Objects = Objects(mobileAdvancedSearches: mobileAdvancedSearches, mobileSmartGroups: mobileSmartGroups, mobileStaticGroups: mobileStaticGroups)
        let results: [MobileAdvancedSearch] = Reporter.mobileAdvancedSearchesInvalidCriteria(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileAdvancedSearchesInvalidCriteria() throws {
        let criteria: [Criterion] = [Criterion(name: "Mobile Device Group", value: "Incorrect Smart Group"), Criterion(name: "Mobile Device Group", value: "Incorrect Static Group")]
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: criteria)]
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1, name: "Smart Group")]
        let mobileStaticGroups: [StaticGroup] = [StaticGroup(id: 2, name: "Static Group")]
        let objects: Objects = Objects(mobileAdvancedSearches: mobileAdvancedSearches, mobileSmartGroups: mobileSmartGroups, mobileStaticGroups: mobileStaticGroups)
        let results: [MobileAdvancedSearch] = Reporter.mobileAdvancedSearchesInvalidCriteria(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileApplicationsScopeTargets() throws {
        let mobileApplications: [MobileApplication] = [
            MobileApplication(id: 1, mobileTargets: MobileTargets(allDevices: true)),
            MobileApplication(id: 2, mobileTargets: MobileTargets(buildings: [1])),
            MobileApplication(id: 3, mobileTargets: MobileTargets(departments: [1])),
            MobileApplication(id: 4, mobileTargets: MobileTargets(devices: [1])),
            MobileApplication(id: 5, mobileTargets: MobileTargets(deviceGroups: [1])),
            MobileApplication(id: 6, mobileExclusions: MobileExclusions(buildings: [1])),
            MobileApplication(id: 7, mobileExclusions: MobileExclusions(departments: [1])),
            MobileApplication(id: 8, mobileExclusions: MobileExclusions(devices: [1])),
            MobileApplication(id: 9, mobileExclusions: MobileExclusions(deviceGroups: [1])),
            MobileApplication(id: 10, mobileExclusions: MobileExclusions(users: ["User"])),
            MobileApplication(id: 11, mobileExclusions: MobileExclusions(userGroups: ["User Group"])),
            MobileApplication(id: 12, mobileExclusions: MobileExclusions(networkSegments: [1])),
            MobileApplication(id: 13, limitations: Limitations(users: ["User"])),
            MobileApplication(id: 14, limitations: Limitations(userGroups: ["User Group"])),
            MobileApplication(id: 15, limitations: Limitations(networkSegments: [1])),
            MobileApplication(id: 16, limitations: Limitations(iBeacons: [1]))
        ]
        let results: [MobileApplication] = Reporter.mobileApplicationsNoScope(mobileApplications)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileApplicationsNoScope() throws {
        let mobileApplications: [MobileApplication] = [MobileApplication(id: 1)]
        let results: [MobileApplication] = Reporter.mobileApplicationsNoScope(mobileApplications)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileConfigurationProfilesScope() throws {
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [
            MobileConfigurationProfile(id: 1, mobileTargets: MobileTargets(allDevices: true)),
            MobileConfigurationProfile(id: 2, mobileTargets: MobileTargets(buildings: [1])),
            MobileConfigurationProfile(id: 3, mobileTargets: MobileTargets(departments: [1])),
            MobileConfigurationProfile(id: 4, mobileTargets: MobileTargets(devices: [1])),
            MobileConfigurationProfile(id: 5, mobileTargets: MobileTargets(deviceGroups: [1])),
            MobileConfigurationProfile(id: 6, mobileExclusions: MobileExclusions(buildings: [1])),
            MobileConfigurationProfile(id: 7, mobileExclusions: MobileExclusions(departments: [1])),
            MobileConfigurationProfile(id: 8, mobileExclusions: MobileExclusions(devices: [1])),
            MobileConfigurationProfile(id: 9, mobileExclusions: MobileExclusions(deviceGroups: [1])),
            MobileConfigurationProfile(id: 10, mobileExclusions: MobileExclusions(users: ["User"])),
            MobileConfigurationProfile(id: 11, mobileExclusions: MobileExclusions(userGroups: ["User Group"])),
            MobileConfigurationProfile(id: 12, mobileExclusions: MobileExclusions(networkSegments: [1])),
            MobileConfigurationProfile(id: 13, limitations: Limitations(users: ["User"])),
            MobileConfigurationProfile(id: 14, limitations: Limitations(userGroups: ["User Group"])),
            MobileConfigurationProfile(id: 15, limitations: Limitations(networkSegments: [1])),
            MobileConfigurationProfile(id: 16, limitations: Limitations(iBeacons: [1]))
        ]
        let results: [MobileConfigurationProfile] = Reporter.mobileConfigurationProfilesNoScope(mobileConfigurationProfiles)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileConfigurationProfilesNoScope() throws {
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1)]
        let results: [MobileConfigurationProfile] = Reporter.mobileConfigurationProfilesNoScope(mobileConfigurationProfiles)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileDevicesLastInventory30Days() throws {
        let date: Date = Date()

        guard let fifteenDays: Date = Calendar.current.date(byAdding: .day, value: -15, to: date),
            let thirtyDays: Date = Calendar.current.date(byAdding: .day, value: -30, to: date),
            let fortyFiveDays: Date = Calendar.current.date(byAdding: .day, value: -45, to: date) else {
            return
        }

        let mobileDevices: [MobileDevice] = [
            MobileDevice(id: 1, lastInventory: fifteenDays.timeIntervalSince1970, managed: true),
            MobileDevice(id: 2, lastInventory: thirtyDays.timeIntervalSince1970, managed: true),
            MobileDevice(id: 3, lastInventory: fortyFiveDays.timeIntervalSince1970, managed: true),
            MobileDevice(id: 4, lastInventory: fifteenDays.timeIntervalSince1970, managed: false),
            MobileDevice(id: 5, lastInventory: thirtyDays.timeIntervalSince1970, managed: false),
            MobileDevice(id: 6, lastInventory: fortyFiveDays.timeIntervalSince1970, managed: false)
        ]
        let options: [ReportOptionType: Int] = [.mobileDevicesLastInventory: 30]
        let results: [MobileDevice] = Reporter.mobileDevicesLastInventory(mobileDevices, options: options)
        XCTAssertTrue(results.count == 2)
        XCTAssertTrue(results[0].id == 2)
        XCTAssertTrue(results[1].id == 3)
    }

    func testMobileDevicesManaged() throws {
        let mobileDevices: [MobileDevice] = [
            MobileDevice(id: 1, managed: true),
            MobileDevice(id: 2, managed: true)
        ]
        let results: [MobileDevice] = Reporter.mobileDevicesUnmanaged(mobileDevices)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileDevicesUnmanaged() throws {
        let mobileDevices: [MobileDevice] = [
            MobileDevice(id: 1, managed: false),
            MobileDevice(id: 2, managed: false)
        ]
        let results: [MobileDevice] = Reporter.mobileDevicesUnmanaged(mobileDevices)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileExtensionAttributesLinked() throws {
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: [Criterion(name: "Name")])]
        let mobileExtensionAttributes: [MobileExtensionAttribute] = [MobileExtensionAttribute(id: 1, name: "Name")]
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1, criteria: [Criterion(name: "Name")])]
        let objects: Objects = Objects(mobileAdvancedSearches: mobileAdvancedSearches, mobileExtensionAttributes: mobileExtensionAttributes, mobileSmartGroups: mobileSmartGroups)
        let results: [MobileExtensionAttribute] = Reporter.mobileExtensionAttributesNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileExtensionAttributesNotLinked() throws {
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: [Criterion()])]
        let mobileExtensionAttributes: [MobileExtensionAttribute] = [MobileExtensionAttribute(id: 1, name: "Name")]
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1, criteria: [Criterion()])]
        let objects: Objects = Objects(mobileAdvancedSearches: mobileAdvancedSearches, mobileExtensionAttributes: mobileExtensionAttributes, mobileSmartGroups: mobileSmartGroups)
        let results: [MobileExtensionAttribute] = Reporter.mobileExtensionAttributesNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileSmartGroupsLinked() throws {
        let mobileTargets: MobileTargets = MobileTargets(deviceGroups: [1])
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: [Criterion(name: "Mobile Device Group", type: "Type", value: "Smart Group")])]
        let mobileApplications: [MobileApplication] = [MobileApplication(id: 1, mobileTargets: mobileTargets)]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, mobileTargets: mobileTargets)]
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1, name: "Smart Group")]
        let objects: Objects = Objects(
            mobileAdvancedSearches: mobileAdvancedSearches,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileSmartGroups: mobileSmartGroups
        )
        let results: [SmartGroup] = Reporter.mobileSmartGroupsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileSmartGroupsNotLinked() throws {
        let mobileTargets: MobileTargets = MobileTargets(deviceGroups: [2])
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: [Criterion(name: "Mobile Device Group", type: "Type", value: "Unique Smart Group #2")])]
        let mobileApplications: [MobileApplication] = [MobileApplication(id: 1, mobileTargets: mobileTargets)]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, mobileTargets: mobileTargets)]
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1, name: "Uniqie Smart Group #1")]
        let objects: Objects = Objects(
            mobileAdvancedSearches: mobileAdvancedSearches,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileSmartGroups: mobileSmartGroups
        )
        let results: [SmartGroup] = Reporter.mobileSmartGroupsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileSmartGroupsCriteria() throws {
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1)]
        let results: [SmartGroup] = Reporter.mobileSmartGroupsNoCriteria(mobileSmartGroups)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileSmartGroupsNoCriteria() throws {
        let mobileSmartGroups: [SmartGroup] = [SmartGroup(id: 1, criteria: [Criterion(name: "Name", type: "Type", value: "Value")])]
        let results: [SmartGroup] = Reporter.mobileSmartGroupsNoCriteria(mobileSmartGroups)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileStaticGroupsLinked() throws {
        let mobileTargets: MobileTargets = MobileTargets(deviceGroups: [1])
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: [Criterion(name: "Mobile Device Group", type: "Type", value: "Static Group")])]
        let mobileApplications: [MobileApplication] = [MobileApplication(id: 1, mobileTargets: mobileTargets)]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, mobileTargets: mobileTargets)]
        let mobileStaticGroups: [StaticGroup] = [StaticGroup(id: 1, name: "Static Group")]
        let objects: Objects = Objects(
            mobileAdvancedSearches: mobileAdvancedSearches,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileStaticGroups: mobileStaticGroups
        )
        let results: [StaticGroup] = Reporter.mobileStaticGroupsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileStaticGroupsNotLinked() throws {
        let mobileTargets: MobileTargets = MobileTargets(deviceGroups: [2])
        let mobileAdvancedSearches: [MobileAdvancedSearch] = [MobileAdvancedSearch(id: 1, criteria: [Criterion(name: "Mobile Device Group", type: "Type", value: "Unique Static Group #2")])]
        let mobileApplications: [MobileApplication] = [MobileApplication(id: 1, mobileTargets: mobileTargets)]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, mobileTargets: mobileTargets)]
        let mobileStaticGroups: [StaticGroup] = [StaticGroup(id: 1, name: "Uniqie Static Group #1")]
        let objects: Objects = Objects(
            mobileAdvancedSearches: mobileAdvancedSearches,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileStaticGroups: mobileStaticGroups
        )
        let results: [StaticGroup] = Reporter.mobileStaticGroupsNotLinked(objects)
        XCTAssertFalse(results.isEmpty)
    }

    func testMobileStaticGroupsNotEmpty() throws {
        let mobileStaticGroups: [StaticGroup] = [StaticGroup(id: 1, devices: [1])]
        let results: [StaticGroup] = Reporter.mobileStaticGroupsEmpty(mobileStaticGroups)
        XCTAssertTrue(results.isEmpty)
    }

    func testMobileStaticGroupsEmpty() throws {
        let mobileStaticGroups: [StaticGroup] = [StaticGroup(id: 1)]
        let results: [StaticGroup] = Reporter.mobileStaticGroupsEmpty(mobileStaticGroups)
        XCTAssertFalse(results.isEmpty)
    }
}
