//
//  MacPatchSoftwareTitle.swift
//  KMART
//
//  Created by Nindi Gill on 27/5/2022.
//

import Foundation
import SWXMLHash

struct MacPatchSoftwareTitle: Codable, XMLObjectDeserialization {
    var id: Int = -1
    var name: String = ""
    var category: Int = -1
    var packages: [Int] = []
    var dictionary: [String: Any] {
        [
            "id": id,
            "name": name,
            "category": category
        ]
    }

    static func deserialize(_ node: XMLIndexer) throws -> MacPatchSoftwareTitle {

        var packages: [Int] = []

        for element in node["patch_software_title"]["versions"]["version"].all {

            guard let child = element["package"]["id"].element,
                let package: Int = Int(child.text) else {
                continue
            }

            packages.append(package)
        }

        return try MacPatchSoftwareTitle(
            id: node["patch_software_title"]["id"].value(),
            name: node["patch_software_title"]["name"].value(),
            category: node["patch_software_title"]["category"]["id"].value(),
            packages: packages
        )
    }
}
