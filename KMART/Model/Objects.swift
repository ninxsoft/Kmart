//
//  Objects.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation

// swiftlint:disable file_length

/// Objects struct storing all Jamf Endpoint results.
struct Objects {
    /// buildings
    var buildings: [Building] = []
    /// categories
    var categories: [Category] = []
    /// departments
    var departments: [Department] = []
    /// ebooks
    var eBooks: [EBook] = []
    /// ibeacons
    var iBeacons: [IBeacon] = []
    /// network segments
    var networkSegments: [NetworkSegment] = []
    /// mac advanced searches
    var macAdvancedSearches: [MacAdvancedSearch] = []
    /// mac applications
    var macApplications: [MacApplication] = []
    /// mac configuration profiles
    var macConfigurationProfiles: [MacConfigurationProfile] = []
    /// mac devices
    var macDevices: [MacDevice] = []
    /// mac devices history
    var macDevicesHistory: [MacDeviceHistory] = []
    /// mac directory bindings
    var macDirectoryBindings: [MacDirectoryBinding] = []
    /// mac disk encrpytions
    var macDiskEncryptions: [MacDiskEncryption] = []
    /// mac dock items
    var macDockItems: [MacDockItem] = []
    /// mac extension attributes
    var macExtensionAttributes: [MacExtensionAttribute] = []
    /// mac packages
    var macPackages: [MacPackage] = []
    /// mac policies
    var macPolicies: [MacPolicy] = []
    /// mac printers
    var macPrinters: [MacPrinter] = []
    /// mac restricted softwares
    var macRestrictedSoftwares: [MacRestrictedSoftware] = []
    /// mac scripts
    var macScripts: [MacScript] = []
    /// mac smart groups
    var macSmartGroups: [SmartGroup] = []
    /// mac static groups
    var macStaticGroups: [StaticGroup] = []
    /// mobile advanced searches
    var mobileAdvancedSearches: [MobileAdvancedSearch] = []
    /// mobile applications
    var mobileApplications: [MobileApplication] = []
    /// mobile configuration profiles
    var mobileConfigurationProfiles: [MobileConfigurationProfile] = []
    /// mobile devices
    var mobileDevices: [MobileDevice] = []
    /// mobile extension attributes
    var mobileExtensionAttributes: [MobileExtensionAttribute] = []
    /// mobile smart groups
    var mobileSmartGroups: [SmartGroup] = []
    /// mobile static groups
    var mobileStaticGroups: [StaticGroup] = []

    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length

    /// Inserts the provided dictionary for the given endpoint type.
    ///
    /// - Parameters:
    ///   - dictionary: The dictionary to be inserted.
    ///   - endpoint: The type of endpoint corresponding to the dictionary data.
    mutating func insert(_ dictionary: [String: Any], for endpoint: Endpoint) {

        do {
            let data: Data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)

            switch endpoint {
            case .buildings:
                try insertBuilding(using: data)
            case .categories:
                try insertCategory(using: data)
            case .departments:
                try insertDepartment(using: data)
            case .eBooks:
                try insertEBook(using: data)
            case .iBeacons:
                try insertIBeacon(using: data)
            case .networkSegments:
                try insertNetworkSegment(using: data)
            case .macAdvancedSearches:
                try insertMacAdvancedSearch(using: data)
            case .macApplications:
                try insertMacApplication(using: data)
            case .macConfigurationProfiles:
                try insertMacConfigurationProfile(using: data)
            case .macDevices:
                try insertMacDevice(using: data)
            case .macDevicesHistory:
                try insertMacDeviceHistory(using: data)
            case .macDirectoryBindings:
                try insertMacDirectoryBinding(using: data)
            case .macDiskEncryptions:
                try insertMacDiskEncryption(using: data)
            case .macDockItems:
                try insertMacDockItem(using: data)
            case .macExtensionAttributes:
                try insertMacExtensionAttribute(using: data)
            case .macGroups:
                try insertMacGroup(using: data)
            case .macPackages:
                try insertMacPackage(using: data)
            case .macPolicies:
                try insertMacPolicy(using: data)
            case .macPrinters:
                try insertMacPrinter(using: data)
            case .macRestrictedSoftware:
                try insertMacRestrictedSoftware(using: data)
            case .macScripts:
                try insertMacScript(using: data)
            case .mobileAdvancedSearches:
                try insertMobileAdvancedSearch(using: data)
            case .mobileApplications:
                try insertMobileApplication(using: data)
            case .mobileConfigurationProfiles:
                try insertMobileConfigurationProfile(using: data)
            case .mobileDevices:
                try insertMobileDevice(using: data)
            case .mobileExtensionAttributes:
                try insertMobileExtensionAttribute(using: data)
            case .mobileGroups:
                try insertMobileGroup(using: data)
            }
        } catch {
            PrettyPrint.print(error.localizedDescription, prefixColor: .red)
        }
    }

    // swiftlint:enable cyclomatic_complexity
    // swiftlint:enable function_body_length

    /// Inserts the provided dictionary data into the **Buildings** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertBuilding(using data: Data) throws {
        let building: Building = try JSONDecoder().decode(Building.self, from: data)
        buildings.append(building)
    }

    /// Inserts the provided dictionary data into the **Categories** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertCategory(using data: Data) throws {
        let category: Category = try JSONDecoder().decode(Category.self, from: data)
        categories.append(category)
    }

    /// Inserts the provided dictionary data into the **Departments** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertDepartment(using data: Data) throws {
        let department: Department = try JSONDecoder().decode(Department.self, from: data)
        departments.append(department)
    }

    /// Inserts the provided dictionary data into the **eBooks** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertEBook(using data: Data) throws {
        let eBook: EBook = try JSONDecoder().decode(EBook.self, from: data)
        eBooks.append(eBook)
    }

    /// Inserts the provided dictionary data into the **iBeacons** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertIBeacon(using data: Data) throws {
        let iBeacon: IBeacon = try JSONDecoder().decode(IBeacon.self, from: data)
        iBeacons.append(iBeacon)
    }

    /// Inserts the provided dictionary data into the **Network Segments** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertNetworkSegment(using data: Data) throws {
        let networkSegment: NetworkSegment = try JSONDecoder().decode(NetworkSegment.self, from: data)
        networkSegments.append(networkSegment)
    }

    /// Inserts the provided dictionary data into the **Mac Advanced Searches** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacAdvancedSearch(using data: Data) throws {
        let macAdvancedSearch: MacAdvancedSearch = try JSONDecoder().decode(MacAdvancedSearch.self, from: data)
        macAdvancedSearches.append(macAdvancedSearch)
    }

    /// Inserts the provided dictionary data into the **Mac Applications** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacApplication(using data: Data) throws {
        let macApplication: MacApplication = try JSONDecoder().decode(MacApplication.self, from: data)
        macApplications.append(macApplication)
    }

    /// Inserts the provided dictionary data into the **Mac Configuration Profiles** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacConfigurationProfile(using data: Data) throws {
        let macConfigurationProfile: MacConfigurationProfile = try JSONDecoder().decode(MacConfigurationProfile.self, from: data)
        macConfigurationProfiles.append(macConfigurationProfile)
    }

    /// Inserts the provided dictionary data into the **Mac Devices** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacDevice(using data: Data) throws {
        let macDevice: MacDevice = try JSONDecoder().decode(MacDevice.self, from: data)
        macDevices.append(macDevice)
    }

    /// Inserts the provided dictionary data into the **Mac Devices History** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacDeviceHistory(using data: Data) throws {
        let macDeviceHistory: MacDeviceHistory = try JSONDecoder().decode(MacDeviceHistory.self, from: data)
        macDevicesHistory.append(macDeviceHistory)
    }

    /// Inserts the provided dictionary data into the **Mac Directory Bindings** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacDirectoryBinding(using data: Data) throws {
        let macDirectoryBinding: MacDirectoryBinding = try JSONDecoder().decode(MacDirectoryBinding.self, from: data)
        macDirectoryBindings.append(macDirectoryBinding)
    }

    /// Inserts the provided dictionary data into the **Mac Disk Encrpyions** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacDiskEncryption(using data: Data) throws {
        let macDiskEncryption: MacDiskEncryption = try JSONDecoder().decode(MacDiskEncryption.self, from: data)
        macDiskEncryptions.append(macDiskEncryption)
    }

    /// Inserts the provided dictionary data into the **Mac Dock Items** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacDockItem(using data: Data) throws {
        let macDockItem: MacDockItem = try JSONDecoder().decode(MacDockItem.self, from: data)
        macDockItems.append(macDockItem)
    }

    /// Inserts the provided dictionary data into the **Mac Extension Attributes** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacExtensionAttribute(using data: Data) throws {
        let macExtensionAttribute: MacExtensionAttribute = try JSONDecoder().decode(MacExtensionAttribute.self, from: data)
        macExtensionAttributes.append(macExtensionAttribute)
    }

    /// Inserts the provided dictionary data into the **Mac Smart / Static Group** arrays.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
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

    /// Inserts the provided dictionary data into the **Mac Packages** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacPackage(using data: Data) throws {
        let macPackage: MacPackage = try JSONDecoder().decode(MacPackage.self, from: data)
        macPackages.append(macPackage)
    }

    /// Inserts the provided dictionary data into the **Mac Policies** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacPolicy(using data: Data) throws {
        let macPolicy: MacPolicy = try JSONDecoder().decode(MacPolicy.self, from: data)
        macPolicies.append(macPolicy)
    }

    /// Inserts the provided dictionary data into the **Mac Printers** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacPrinter(using data: Data) throws {
        let macPrinter: MacPrinter = try JSONDecoder().decode(MacPrinter.self, from: data)
        macPrinters.append(macPrinter)
    }

    /// Inserts the provided dictionary data into the **Mac Restricted Softwares** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacRestrictedSoftware(using data: Data) throws {
        let macRestrictedSoftware: MacRestrictedSoftware = try JSONDecoder().decode(MacRestrictedSoftware.self, from: data)
        macRestrictedSoftwares.append(macRestrictedSoftware)
    }

    /// Inserts the provided dictionary data into the **Mac Scripts** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMacScript(using data: Data) throws {
        let macScript: MacScript = try JSONDecoder().decode(MacScript.self, from: data)
        macScripts.append(macScript)
    }

    /// Inserts the provided dictionary data into the **Mobile Advanced Searches** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMobileAdvancedSearch(using data: Data) throws {
        let mobileAdvancedSearch: MobileAdvancedSearch = try JSONDecoder().decode(MobileAdvancedSearch.self, from: data)
        mobileAdvancedSearches.append(mobileAdvancedSearch)
    }

    /// Inserts the provided dictionary data into the **Mobile Applications** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMobileApplication(using data: Data) throws {
        let mobileApplication: MobileApplication = try JSONDecoder().decode(MobileApplication.self, from: data)
        mobileApplications.append(mobileApplication)
    }

    /// Inserts the provided dictionary data into the **Mobile Configuration Profiles** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMobileConfigurationProfile(using data: Data) throws {
        let mobileConfigurationProfile: MobileConfigurationProfile = try JSONDecoder().decode(MobileConfigurationProfile.self, from: data)
        mobileConfigurationProfiles.append(mobileConfigurationProfile)
    }

    /// Inserts the provided dictionary data into the **Mobile Devices** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMobileDevice(using data: Data) throws {
        let mobileDevice: MobileDevice = try JSONDecoder().decode(MobileDevice.self, from: data)
        mobileDevices.append(mobileDevice)
    }

    /// Inserts the provided dictionary data into the **Mobile Extension Attributes** array.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
    private mutating func insertMobileExtensionAttribute(using data: Data) throws {
        let mobileExtensionAttribute: MobileExtensionAttribute = try JSONDecoder().decode(MobileExtensionAttribute.self, from: data)
        mobileExtensionAttributes.append(mobileExtensionAttribute)
    }

    /// Inserts the provided dictionary data into the **Mobile Smart / Static Group** arrays.
    ///
    /// - Parameters:
    ///   - data: The dictionary data to be inserted.
    /// - Throws: An exception if the provided dictionary data is malformed.
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
