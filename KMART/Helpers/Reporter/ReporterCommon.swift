//
//  ReporterCommon.swift
//  KMART
//
//  Created by Nindi Gill on 27/2/21.
//

import Foundation

struct ReporterCommon {

    static func update(_ reports: inout Reports, with report: ReportType, from objects: Objects) {

        switch report {
        case .buildingsNotLinked:       reports.buildingsNotLinked.append(contentsOf: buildingsNotLinked(objects))
        case .categoriesNotLinked:      reports.categoriesNotLinked.append(contentsOf: categoriesNotLinked(objects))
        case .departmentsNotLinked:     reports.departmentsNotLinked.append(contentsOf: departmentsNotLinked(objects))
        case .eBooksNoScope:            reports.eBooksNoScope.append(contentsOf: eBooksNoScope(objects.eBooks))
        case .iBeaconsNotLinked:        reports.iBeaconsNotLinked.append(contentsOf: iBeaconsNotLinked(objects))
        case .networkSegmentsNotLinked: reports.networkSegmentsNotLinked.append(contentsOf: networkSegmentsNotLinked(objects))
        default:
            break
        }
    }

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

    static func eBooksNoScope(_ eBooks: [EBook]) -> [EBook] {
        eBooks.filter { !$0.scope }
    }

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
}
