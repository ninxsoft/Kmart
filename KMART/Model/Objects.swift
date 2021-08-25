//
//  Objects.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation

struct Objects {
    var buildings: [Building] = []
    var categories: [Category] = []
    var departments: [Department] = []
    var eBooks: [EBook] = []
    var iBeacons: [IBeacon] = []
    var networkSegments: [NetworkSegment] = []
    var macAdvancedSearches: [MacAdvancedSearch] = []
    var macApplications: [MacApplication] = []
    var macConfigurationProfiles: [MacConfigurationProfile] = []
    var macDevices: [MacDevice] = []
    var macDevicesHistory: [MacDeviceHistory] = []
    var macDirectoryBindings: [MacDirectoryBinding] = []
    var macDiskEncryptions: [MacDiskEncryption] = []
    var macDockItems: [MacDockItem] = []
    var macExtensionAttributes: [MacExtensionAttribute] = []
    var macPackages: [MacPackage] = []
    var macPolicies: [MacPolicy] = []
    var macPrinters: [MacPrinter] = []
    var macRestrictedSoftwares: [MacRestrictedSoftware] = []
    var macScripts: [MacScript] = []
    var macSmartGroups: [SmartGroup] = []
    var macStaticGroups: [StaticGroup] = []
    var mobileAdvancedSearches: [MobileAdvancedSearch] = []
    var mobileApplications: [MobileApplication] = []
    var mobileConfigurationProfiles: [MobileConfigurationProfile] = []
    var mobileDevices: [MobileDevice] = []
    var mobileExtensionAttributes: [MobileExtensionAttribute] = []
    var mobileSmartGroups: [SmartGroup] = []
    var mobileStaticGroups: [StaticGroup] = []

    mutating func insert(_ dictionary: [String: Any], for endpoint: Endpoint) {

        do {
            let data: Data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)

            switch endpoint {
            case .buildings, .categories, .departments, .eBooks, .iBeacons, .networkSegments:
                try insertCommon(endpoint, using: data)
            case .macAdvancedSearches, .macApplications, .macConfigurationProfiles, .macDevices, .macDevicesHistory, .macDirectoryBindings, .macDiskEncryptions, .macDockItems,
                .macExtensionAttributes, .macGroups, .macPackages, .macPolicies, .macPrinters, .macRestrictedSoftware, .macScripts:
                try insertMac(endpoint, using: data)
            case .mobileAdvancedSearches, .mobileApplications, .mobileConfigurationProfiles, .mobileDevices, .mobileExtensionAttributes, .mobileGroups:
                try insertMobile(endpoint, using: data)
            }
        } catch {
            PrettyPrint.print(error.localizedDescription)
        }
    }

    private mutating func insertCommon(_ endpoint: Endpoint, using data: Data) throws {

        switch endpoint {
        case .buildings:       try insertBuilding(using: data)
        case .categories:      try insertCategory(using: data)
        case .departments:     try insertDepartment(using: data)
        case .eBooks:          try insertEBook(using: data)
        case .iBeacons:        try insertIBeacon(using: data)
        case .networkSegments: try insertNetworkSegment(using: data)
        default:               return
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private mutating func insertMac(_ endpoint: Endpoint, using data: Data) throws {

        switch endpoint {
        case .macAdvancedSearches:      try insertMacAdvancedSearch(using: data)
        case .macApplications:          try insertMacApplication(using: data)
        case .macConfigurationProfiles: try insertMacConfigurationProfile(using: data)
        case .macDevices:               try insertMacDevice(using: data)
        case .macDevicesHistory:        try insertMacDeviceHistory(using: data)
        case .macDirectoryBindings:     try insertMacDirectoryBinding(using: data)
        case .macDiskEncryptions:       try insertMacDiskEncryption(using: data)
        case .macDockItems:             try insertMacDockItem(using: data)
        case .macExtensionAttributes:   try insertMacExtensionAttribute(using: data)
        case .macGroups:                try insertMacGroup(using: data)
        case .macPackages:              try insertMacPackage(using: data)
        case .macPolicies:              try insertMacPolicy(using: data)
        case .macPrinters:              try insertMacPrinter(using: data)
        case .macRestrictedSoftware:    try insertMacRestrictedSoftware(using: data)
        case .macScripts:               try insertMacScript(using: data)
        default:                        return
        }
    }

    private mutating func insertMobile(_ endpoint: Endpoint, using data: Data) throws {

        switch endpoint {
        case .mobileAdvancedSearches:      try insertMobileAdvancedSearch(using: data)
        case .mobileApplications:          try insertMobileApplication(using: data)
        case .mobileConfigurationProfiles: try insertMobileConfigurationProfile(using: data)
        case .mobileDevices:               try insertMobileDevice(using: data)
        case .mobileExtensionAttributes:   try insertMobileExtensionAttribute(using: data)
        case .mobileGroups:                try insertMobileGroup(using: data)
        default:                           return
        }
    }

    private mutating func insertBuilding(using data: Data) throws {
        let building: Building = try JSONDecoder().decode(Building.self, from: data)
        buildings.append(building)
    }

    private mutating func insertCategory(using data: Data) throws {
        let category: Category = try JSONDecoder().decode(Category.self, from: data)
        categories.append(category)
    }

    private mutating func insertDepartment(using data: Data) throws {
        let department: Department = try JSONDecoder().decode(Department.self, from: data)
        departments.append(department)
    }

    private mutating func insertEBook(using data: Data) throws {
        let eBook: EBook = try JSONDecoder().decode(EBook.self, from: data)
        eBooks.append(eBook)
    }

    private mutating func insertIBeacon(using data: Data) throws {
        let iBeacon: IBeacon = try JSONDecoder().decode(IBeacon.self, from: data)
        iBeacons.append(iBeacon)
    }

    private mutating func insertNetworkSegment(using data: Data) throws {
        let networkSegment: NetworkSegment = try JSONDecoder().decode(NetworkSegment.self, from: data)
        networkSegments.append(networkSegment)
    }

    private mutating func insertMacAdvancedSearch(using data: Data) throws {
        let macAdvancedSearch: MacAdvancedSearch = try JSONDecoder().decode(MacAdvancedSearch.self, from: data)
        macAdvancedSearches.append(macAdvancedSearch)
    }

    private mutating func insertMacApplication(using data: Data) throws {
        let macApplication: MacApplication = try JSONDecoder().decode(MacApplication.self, from: data)
        macApplications.append(macApplication)
    }

    private mutating func insertMacConfigurationProfile(using data: Data) throws {
        let macConfigurationProfile: MacConfigurationProfile = try JSONDecoder().decode(MacConfigurationProfile.self, from: data)
        macConfigurationProfiles.append(macConfigurationProfile)
    }

    private mutating func insertMacDevice(using data: Data) throws {
        let macDevice: MacDevice = try JSONDecoder().decode(MacDevice.self, from: data)
        macDevices.append(macDevice)
    }

    private mutating func insertMacDeviceHistory(using data: Data) throws {
        let macDeviceHistory: MacDeviceHistory = try JSONDecoder().decode(MacDeviceHistory.self, from: data)
        macDevicesHistory.append(macDeviceHistory)
    }

    private mutating func insertMacDirectoryBinding(using data: Data) throws {
        let macDirectoryBinding: MacDirectoryBinding = try JSONDecoder().decode(MacDirectoryBinding.self, from: data)
        macDirectoryBindings.append(macDirectoryBinding)
    }

    private mutating func insertMacDiskEncryption(using data: Data) throws {
        let macDiskEncryption: MacDiskEncryption = try JSONDecoder().decode(MacDiskEncryption.self, from: data)
        macDiskEncryptions.append(macDiskEncryption)
    }

    private mutating func insertMacDockItem(using data: Data) throws {
        let macDockItem: MacDockItem = try JSONDecoder().decode(MacDockItem.self, from: data)
        macDockItems.append(macDockItem)
    }

    private mutating func insertMacExtensionAttribute(using data: Data) throws {
        let macExtensionAttribute: MacExtensionAttribute = try JSONDecoder().decode(MacExtensionAttribute.self, from: data)
        macExtensionAttributes.append(macExtensionAttribute)
    }

    private mutating func insertMacGroup(using data: Data) throws {

        guard let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let smart: Bool = dictionary["is_smart"] as? Bool else {
            return
        }

        if smart {
            let macSmartGroup: SmartGroup = try JSONDecoder().decode(SmartGroup.self, from: data)
            macSmartGroups.append(macSmartGroup)
        } else {
            let macStaticGroup: StaticGroup = try JSONDecoder().decode(StaticGroup.self, from: data)
            macStaticGroups.append(macStaticGroup)
        }
    }

    private mutating func insertMacPackage(using data: Data) throws {
        let macPackage: MacPackage = try JSONDecoder().decode(MacPackage.self, from: data)
        macPackages.append(macPackage)
    }

    private mutating func insertMacPolicy(using data: Data) throws {
        let macPolicy: MacPolicy = try JSONDecoder().decode(MacPolicy.self, from: data)
        macPolicies.append(macPolicy)
    }

    private mutating func insertMacPrinter(using data: Data) throws {
        let macPrinter: MacPrinter = try JSONDecoder().decode(MacPrinter.self, from: data)
        macPrinters.append(macPrinter)
    }

    private mutating func insertMacRestrictedSoftware(using data: Data) throws {
        let macRestrictedSoftware: MacRestrictedSoftware = try JSONDecoder().decode(MacRestrictedSoftware.self, from: data)
        macRestrictedSoftwares.append(macRestrictedSoftware)
    }

    private mutating func insertMacScript(using data: Data) throws {
        let macScript: MacScript = try JSONDecoder().decode(MacScript.self, from: data)
        macScripts.append(macScript)
    }

    private mutating func insertMobileAdvancedSearch(using data: Data) throws {
        let mobileAdvancedSearch: MobileAdvancedSearch = try JSONDecoder().decode(MobileAdvancedSearch.self, from: data)
        mobileAdvancedSearches.append(mobileAdvancedSearch)
    }

    private mutating func insertMobileApplication(using data: Data) throws {
        let mobileApplication: MobileApplication = try JSONDecoder().decode(MobileApplication.self, from: data)
        mobileApplications.append(mobileApplication)
    }

    private mutating func insertMobileConfigurationProfile(using data: Data) throws {
        let mobileConfigurationProfile: MobileConfigurationProfile = try JSONDecoder().decode(MobileConfigurationProfile.self, from: data)
        mobileConfigurationProfiles.append(mobileConfigurationProfile)
    }

    private mutating func insertMobileDevice(using data: Data) throws {
        let mobileDevice: MobileDevice = try JSONDecoder().decode(MobileDevice.self, from: data)
        mobileDevices.append(mobileDevice)
    }

    private mutating func insertMobileExtensionAttribute(using data: Data) throws {
        let mobileExtensionAttribute: MobileExtensionAttribute = try JSONDecoder().decode(MobileExtensionAttribute.self, from: data)
        mobileExtensionAttributes.append(mobileExtensionAttribute)
    }

    private mutating func insertMobileGroup(using data: Data) throws {

        guard let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let smart: Bool = dictionary["is_smart"] as? Bool  else {
            return
        }

        if smart {
            let mobileSmartGroup: SmartGroup = try JSONDecoder().decode(SmartGroup.self, from: data)
            mobileSmartGroups.append(mobileSmartGroup)
        } else {
            let mobileStaticGroup: StaticGroup = try JSONDecoder().decode(StaticGroup.self, from: data)
            mobileStaticGroups.append(mobileStaticGroup)
        }
    }
}
