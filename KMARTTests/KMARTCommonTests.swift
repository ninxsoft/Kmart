//
//  KMARTCommonTests.swift
//  KMARTTests
//
//  Created by Nindi Gill on 28/2/21.
//

import XCTest

// swiftlint:disable file_length
// swiftlint:disable:next type_body_length
class KMARTCommonTests: XCTestCase {

    func testBuildingsLinked() throws {
        let buildings: [Building] = (1...15).map { Building(id: $0, name: "Building #\($0)") }
        let networkSegments: [NetworkSegment] = [NetworkSegment(id: 1, building: "Building #1")]
        let macApplications: [MacApplication] = [
            MacApplication(id: 1, macTargets: MacTargets(buildings: [2])),
            MacApplication(id: 2, macExclusions: MacExclusions(buildings: [3]))
        ]
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macTargets: MacTargets(buildings: [4])),
            MacConfigurationProfile(id: 2, macExclusions: MacExclusions(buildings: [5]))
        ]
        let macDevices: [MacDevice] = [MacDevice(id: 1, building: "Building #6")]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macTargets: MacTargets(buildings: [7])),
            MacPolicy(id: 2, macExclusions: MacExclusions(buildings: [8]))
        ]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [
            MacRestrictedSoftware(id: 1, macTargets: MacTargets(buildings: [9])),
            MacRestrictedSoftware(id: 2, macExclusions: MacExclusions(buildings: [10]))
        ]
        let mobileApplications: [MobileApplication] = [
            MobileApplication(id: 1, mobileTargets: MobileTargets(buildings: [11])),
            MobileApplication(id: 2, mobileExclusions: MobileExclusions(buildings: [12]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [
            MobileConfigurationProfile(id: 1, mobileTargets: MobileTargets(buildings: [13])),
            MobileConfigurationProfile(id: 2, mobileExclusions: MobileExclusions(buildings: [14]))
        ]
        let mobileDevices: [MobileDevice] = [MobileDevice(id: 1, building: "Building #15")]
        let objects: Objects = Objects(
            buildings: buildings,
            networkSegments: networkSegments,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macDevices: macDevices,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileDevices: mobileDevices
        )
        let results: [Building] = Reporter.buildingsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testBuildingsNotLinked() throws {
        let buildings: [Building] = (1...16).map { Building(id: $0, name: "Building #\($0)") }
        let networkSegments: [NetworkSegment] = [NetworkSegment(id: 1, building: "Building #1")]
        let macApplications: [MacApplication] = [
            MacApplication(id: 1, macTargets: MacTargets(buildings: [2])),
            MacApplication(id: 2, macExclusions: MacExclusions(buildings: [3]))
        ]
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macTargets: MacTargets(buildings: [4])),
            MacConfigurationProfile(id: 2, macExclusions: MacExclusions(buildings: [5]))
        ]
        let macDevices: [MacDevice] = [MacDevice(id: 1, building: "Building #6")]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macTargets: MacTargets(buildings: [7])),
            MacPolicy(id: 2, macExclusions: MacExclusions(buildings: [8]))
        ]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [
            MacRestrictedSoftware(id: 1, macTargets: MacTargets(buildings: [9])),
            MacRestrictedSoftware(id: 2, macExclusions: MacExclusions(buildings: [10]))
        ]
        let mobileApplications: [MobileApplication] = [
            MobileApplication(id: 1, mobileTargets: MobileTargets(buildings: [11])),
            MobileApplication(id: 2, mobileExclusions: MobileExclusions(buildings: [12]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [
            MobileConfigurationProfile(id: 1, mobileTargets: MobileTargets(buildings: [13])),
            MobileConfigurationProfile(id: 2, mobileExclusions: MobileExclusions(buildings: [14]))
        ]
        let mobileDevices: [MobileDevice] = [MobileDevice(id: 1, building: "Building #15")]
        let objects: Objects = Objects(
            buildings: buildings,
            networkSegments: networkSegments,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macDevices: macDevices,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileDevices: mobileDevices
        )
        let results: [Building] = Reporter.buildingsNotLinked(objects)
        XCTAssertTrue(results.count == 1)
        XCTAssertTrue(results.first?.id == buildings.last?.id)
    }

    func testCategoriesLinked() throws {
        let categories: [Category] = (1...8).map { Category(id: $0, name: "Category #\($0)") }
        let macApplications: [MacApplication] = [MacApplication(id: 1, category: 1)]
        let macConfigurationProfiles: [MacConfigurationProfile] = [MacConfigurationProfile(id: 1, category: 2)]
        let macPackages: [MacPackage] = [MacPackage(id: 1, category: "Category #3")]
        let macPatchSoftwareTitles: [MacPatchSoftwareTitle] = [MacPatchSoftwareTitle(id: 1, category: 4)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, category: 5)]
        let macPrinters: [MacPrinter] = [MacPrinter(id: 1, category: "Category #6")]
        let macScripts: [MacScript] = [MacScript(id: 1, category: "Category #7")]
        let mobileApplications: [MobileApplication] = [MobileApplication(id: 1, category: 8)]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, category: 9)]
        let objects: Objects = Objects(
            categories: categories,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPackages: macPackages,
            macPatchSoftwareTitles: macPatchSoftwareTitles,
            macPolicies: macPolicies,
            macPrinters: macPrinters,
            macScripts: macScripts,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles
        )
        let results: [Category] = Reporter.categoriesNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testCategoriesNotLinked() throws {
        let categories: [Category] = (1...10).map { Category(id: $0, name: "Category #\($0)") }
        let macApplications: [MacApplication] = [MacApplication(id: 1, category: 1)]
        let macConfigurationProfiles: [MacConfigurationProfile] = [MacConfigurationProfile(id: 1, category: 2)]
        let macPackages: [MacPackage] = [MacPackage(id: 1, category: "Category #3")]
        let macPatchSoftwareTitles: [MacPatchSoftwareTitle] = [MacPatchSoftwareTitle(id: 1, category: 4)]
        let macPolicies: [MacPolicy] = [MacPolicy(id: 1, category: 5)]
        let macPrinters: [MacPrinter] = [MacPrinter(id: 1, category: "Category #6")]
        let macScripts: [MacScript] = [MacScript(id: 1, category: "Category #7")]
        let mobileApplications: [MobileApplication] = [MobileApplication(id: 1, category: 8)]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, category: 9)]
        let objects: Objects = Objects(
            categories: categories,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPackages: macPackages,
            macPatchSoftwareTitles: macPatchSoftwareTitles,
            macPolicies: macPolicies,
            macPrinters: macPrinters,
            macScripts: macScripts,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles
        )
        let results: [Category] = Reporter.categoriesNotLinked(objects)
        XCTAssertTrue(results.count == 1)
        XCTAssertTrue(results.first?.id == categories.last?.id)
    }

    func testDepartmentsLinked() throws {
        let departments: [Department] = (1...15).map { Department(id: $0, name: "Department #\($0)") }
        let networkSegments: [NetworkSegment] = [NetworkSegment(id: 1, department: "Department #1")]
        let macApplications: [MacApplication] = [
            MacApplication(id: 1, macTargets: MacTargets(departments: [2])),
            MacApplication(id: 2, macExclusions: MacExclusions(departments: [3]))
        ]
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macTargets: MacTargets(departments: [4])),
            MacConfigurationProfile(id: 2, macExclusions: MacExclusions(departments: [5]))
        ]
        let macDevices: [MacDevice] = [MacDevice(id: 1, department: "Department #6")]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macTargets: MacTargets(departments: [7])),
            MacPolicy(id: 2, macExclusions: MacExclusions(departments: [8]))
        ]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [
            MacRestrictedSoftware(id: 1, macTargets: MacTargets(departments: [9])),
            MacRestrictedSoftware(id: 2, macExclusions: MacExclusions(departments: [10]))
        ]
        let mobileApplications: [MobileApplication] = [
            MobileApplication(id: 1, mobileTargets: MobileTargets(departments: [11])),
            MobileApplication(id: 2, mobileExclusions: MobileExclusions(departments: [12]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [
            MobileConfigurationProfile(id: 1, mobileTargets: MobileTargets(departments: [13])),
            MobileConfigurationProfile(id: 2, mobileExclusions: MobileExclusions(departments: [14]))
        ]
        let mobileDevices: [MobileDevice] = [MobileDevice(id: 1, department: "Department #15")]
        let objects: Objects = Objects(
            departments: departments,
            networkSegments: networkSegments,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macDevices: macDevices,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileDevices: mobileDevices
        )
        let results: [Department] = Reporter.departmentsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testDepartmentsNotLinked() throws {
        let departments: [Department] = (1...16).map { Department(id: $0, name: "Department #\($0)") }
        let networkSegments: [NetworkSegment] = [NetworkSegment(id: 1, department: "Department #1")]
        let macApplications: [MacApplication] = [
            MacApplication(id: 1, macTargets: MacTargets(departments: [2])),
            MacApplication(id: 2, macExclusions: MacExclusions(departments: [3]))
        ]
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macTargets: MacTargets(departments: [4])),
            MacConfigurationProfile(id: 2, macExclusions: MacExclusions(departments: [5]))
        ]
        let macDevices: [MacDevice] = [MacDevice(id: 1, department: "Department #6")]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macTargets: MacTargets(departments: [7])),
            MacPolicy(id: 2, macExclusions: MacExclusions(departments: [8]))
        ]
        let macRestrictedSoftwares: [MacRestrictedSoftware] = [
            MacRestrictedSoftware(id: 1, macTargets: MacTargets(departments: [9])),
            MacRestrictedSoftware(id: 2, macExclusions: MacExclusions(departments: [10]))
        ]
        let mobileApplications: [MobileApplication] = [
            MobileApplication(id: 1, mobileTargets: MobileTargets(departments: [11])),
            MobileApplication(id: 2, mobileExclusions: MobileExclusions(departments: [12]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [
            MobileConfigurationProfile(id: 1, mobileTargets: MobileTargets(departments: [13])),
            MobileConfigurationProfile(id: 2, mobileExclusions: MobileExclusions(departments: [14]))
        ]
        let mobileDevices: [MobileDevice] = [MobileDevice(id: 1, department: "Department #15")]
        let objects: Objects = Objects(
            departments: departments,
            networkSegments: networkSegments,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macDevices: macDevices,
            macPolicies: macPolicies,
            macRestrictedSoftwares: macRestrictedSoftwares,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles,
            mobileDevices: mobileDevices
        )
        let results: [Department] = Reporter.departmentsNotLinked(objects)
        XCTAssertTrue(results.count == 1)
        XCTAssertTrue(results.first?.id == departments.last?.id)
    }

    func testEBooksScope() throws {
        let eBooks: [EBook] = [
            EBook(id: 1, macTargets: MacTargets(allDevices: true)),
            EBook(id: 2, macTargets: MacTargets(buildings: [1])),
            EBook(id: 3, macTargets: MacTargets(departments: [1])),
            EBook(id: 4, macTargets: MacTargets(devices: [1])),
            EBook(id: 5, macTargets: MacTargets(deviceGroups: [1])),
            EBook(id: 6, macExclusions: MacExclusions(buildings: [1])),
            EBook(id: 7, macExclusions: MacExclusions(departments: [1])),
            EBook(id: 8, macExclusions: MacExclusions(devices: [1])),
            EBook(id: 9, macExclusions: MacExclusions(deviceGroups: [1])),
            EBook(id: 10, macExclusions: MacExclusions(users: ["User"])),
            EBook(id: 11, macExclusions: MacExclusions(userGroups: ["User Group"])),
            EBook(id: 12, macExclusions: MacExclusions(networkSegments: [1])),
            EBook(id: 13, macExclusions: MacExclusions(iBeacons: [1])),
            EBook(id: 14, mobileTargets: MobileTargets(allDevices: true)),
            EBook(id: 15, mobileTargets: MobileTargets(allUsers: true)),
            EBook(id: 16, mobileTargets: MobileTargets(buildings: [1])),
            EBook(id: 17, mobileTargets: MobileTargets(departments: [1])),
            EBook(id: 18, mobileTargets: MobileTargets(devices: [1])),
            EBook(id: 19, mobileTargets: MobileTargets(deviceGroups: [1])),
            EBook(id: 20, mobileTargets: MobileTargets(users: [1])),
            EBook(id: 21, mobileTargets: MobileTargets(userGroups: [1])),
            EBook(id: 22, mobileExclusions: MobileExclusions(buildings: [1])),
            EBook(id: 23, mobileExclusions: MobileExclusions(departments: [1])),
            EBook(id: 24, mobileExclusions: MobileExclusions(devices: [1])),
            EBook(id: 25, mobileExclusions: MobileExclusions(deviceGroups: [1])),
            EBook(id: 26, mobileExclusions: MobileExclusions(users: ["User"])),
            EBook(id: 27, mobileExclusions: MobileExclusions(userGroups: ["User Group"])),
            EBook(id: 28, mobileExclusions: MobileExclusions(jssUsers: [1])),
            EBook(id: 29, mobileExclusions: MobileExclusions(jssUserGroups: [1])),
            EBook(id: 30, mobileExclusions: MobileExclusions(networkSegments: [1])),
            EBook(id: 31, limitations: Limitations(users: ["User"])),
            EBook(id: 32, limitations: Limitations(userGroups: ["User Group"])),
            EBook(id: 33, limitations: Limitations(networkSegments: [1])),
            EBook(id: 34, limitations: Limitations(iBeacons: [1]))
        ]
        let results: [EBook] = Reporter.eBooksNoScope(eBooks)
        XCTAssertTrue(results.isEmpty)
    }

    func testEBooksNoScope() throws {
        let eBooks: [EBook] = [EBook(id: 1)]
        let results: [EBook] = Reporter.eBooksNoScope(eBooks)
        XCTAssertFalse(results.isEmpty)
    }

    func testIBeaconsLinked() throws {
        let iBeacons: [IBeacon] = (1...5).map { IBeacon(id: $0, name: "iBeacon #\($0)") }
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macExclusions: MacExclusions(iBeacons: [1])),
            MacConfigurationProfile(id: 2, limitations: Limitations(iBeacons: [2]))
        ]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macExclusions: MacExclusions(iBeacons: [3])),
            MacPolicy(id: 2, limitations: Limitations(iBeacons: [4]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, limitations: Limitations(iBeacons: [5]))]
        let objects: Objects = Objects(iBeacons: iBeacons, macConfigurationProfiles: macConfigurationProfiles, macPolicies: macPolicies, mobileConfigurationProfiles: mobileConfigurationProfiles)
        let results: [IBeacon] = Reporter.iBeaconsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testIBeaconsNotLinked() throws {
        let iBeacons: [IBeacon] = (1...6).map { IBeacon(id: $0, name: "iBeacon #\($0)") }
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macExclusions: MacExclusions(iBeacons: [1])),
            MacConfigurationProfile(id: 2, limitations: Limitations(iBeacons: [2]))
        ]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macExclusions: MacExclusions(iBeacons: [3])),
            MacPolicy(id: 2, limitations: Limitations(iBeacons: [4]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [MobileConfigurationProfile(id: 1, limitations: Limitations(iBeacons: [5]))]
        let objects: Objects = Objects(iBeacons: iBeacons, macConfigurationProfiles: macConfigurationProfiles, macPolicies: macPolicies, mobileConfigurationProfiles: mobileConfigurationProfiles)
        let results: [IBeacon] = Reporter.iBeaconsNotLinked(objects)
        XCTAssertTrue(results.count == 1)
        XCTAssertTrue(results.first?.id == iBeacons.last?.id)
    }

    func testNetworkSegmentsLinked() throws {
        let buildings: [Building] = [Building(id: 1, name: "Building")]
        let departments: [Department] = [Department(id: 1, name: "Department")]
        let eBooks: [EBook] = [
            EBook(id: 1, macExclusions: MacExclusions(networkSegments: [3])),
            EBook(id: 2, limitations: Limitations(networkSegments: [4]))
        ]
        let networkSegments: [NetworkSegment] = (1...14).map { NetworkSegment(id: $0, name: "Network Segment #\($0)", building: $0 == 1 ? "Building" : "", department: $0 == 2 ? "Department" : "") }
        let macApplications: [MacApplication] = [
            MacApplication(id: 1, macExclusions: MacExclusions(networkSegments: [5])),
            MacApplication(id: 2, limitations: Limitations(networkSegments: [6]))
        ]
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macExclusions: MacExclusions(networkSegments: [7])),
            MacConfigurationProfile(id: 2, limitations: Limitations(networkSegments: [8]))
        ]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macExclusions: MacExclusions(networkSegments: [9])),
            MacPolicy(id: 2, limitations: Limitations(networkSegments: [10]))
        ]
        let mobileApplications: [MobileApplication] = [
            MobileApplication(id: 1, mobileExclusions: MobileExclusions(networkSegments: [11])),
            MobileApplication(id: 2, limitations: Limitations(networkSegments: [12]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [
            MobileConfigurationProfile(id: 1, mobileExclusions: MobileExclusions(networkSegments: [13])),
            MobileConfigurationProfile(id: 2, limitations: Limitations(networkSegments: [14]))
        ]
        let objects: Objects = Objects(
            buildings: buildings,
            departments: departments,
            eBooks: eBooks,
            networkSegments: networkSegments,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPolicies: macPolicies,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles
        )
        let results: [NetworkSegment] = Reporter.networkSegmentsNotLinked(objects)
        XCTAssertTrue(results.isEmpty)
    }

    func testNetworkSegmentsNotLinked() throws {
        let buildings: [Building] = [Building(id: 1, name: "Building")]
        let departments: [Department] = [Department(id: 1, name: "Department")]
        let eBooks: [EBook] = [
            EBook(id: 1, macExclusions: MacExclusions(networkSegments: [3])),
            EBook(id: 2, limitations: Limitations(networkSegments: [4]))
        ]
        let networkSegments: [NetworkSegment] = (1...15).map { NetworkSegment(id: $0, name: "Network Segment #\($0)", building: $0 == 1 ? "Building" : "", department: $0 == 2 ? "Department" : "") }
        let macApplications: [MacApplication] = [
            MacApplication(id: 1, macExclusions: MacExclusions(networkSegments: [5])),
            MacApplication(id: 2, limitations: Limitations(networkSegments: [6]))
        ]
        let macConfigurationProfiles: [MacConfigurationProfile] = [
            MacConfigurationProfile(id: 1, macExclusions: MacExclusions(networkSegments: [7])),
            MacConfigurationProfile(id: 2, limitations: Limitations(networkSegments: [8]))
        ]
        let macPolicies: [MacPolicy] = [
            MacPolicy(id: 1, macExclusions: MacExclusions(networkSegments: [9])),
            MacPolicy(id: 2, limitations: Limitations(networkSegments: [10]))
        ]
        let mobileApplications: [MobileApplication] = [
            MobileApplication(id: 1, mobileExclusions: MobileExclusions(networkSegments: [11])),
            MobileApplication(id: 2, limitations: Limitations(networkSegments: [12]))
        ]
        let mobileConfigurationProfiles: [MobileConfigurationProfile] = [
            MobileConfigurationProfile(id: 1, mobileExclusions: MobileExclusions(networkSegments: [13])),
            MobileConfigurationProfile(id: 2, limitations: Limitations(networkSegments: [14]))
        ]
        let objects: Objects = Objects(
            buildings: buildings,
            departments: departments,
            eBooks: eBooks,
            networkSegments: networkSegments,
            macApplications: macApplications,
            macConfigurationProfiles: macConfigurationProfiles,
            macPolicies: macPolicies,
            mobileApplications: mobileApplications,
            mobileConfigurationProfiles: mobileConfigurationProfiles
        )
        let results: [NetworkSegment] = Reporter.networkSegmentsNotLinked(objects)
        XCTAssertTrue(results.count == 1)
        XCTAssertTrue(results.first?.id == networkSegments.last?.id)
    }
}
