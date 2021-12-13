//
//  ConfigurationType.swift
//  KMART
//
//  Created by Nindi Gill on 13/12/21.
//

import ArgumentParser
import Foundation

enum ConfigurationType: String, ExpressibleByArgument {
    case json = "JSON"
    case plist = "Property List"
    case yaml = "YAML"
}
