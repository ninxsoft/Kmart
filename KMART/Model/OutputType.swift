//
//  OutputType.swift
//  KMART
//
//  Created by Nindi Gill on 19/2/21.
//

import Foundation

enum OutputType: String, CaseIterable {
    case json = "json"
    case propertyList = "plist"
    case yaml = "yaml"
    case markdown = "markdown"
    case html = "html"

    var description: String {
        switch self {
        case .json:
            return "JSON"
        case .propertyList:
            return "Property List"
        case .yaml:
            return "YAML"
        case .markdown:
            return "Markdown"
        case .html:
            return "HTML"
        }
    }

    var fileExtension: String {
        switch self {
        case .json:
            return "json"
        case .propertyList:
            return "plist"
        case .yaml:
            return "yaml"
        case .markdown:
            return "md"
        case .html:
            return "html"
        }
    }

    var filetype: String {
        switch self {
        case .json:
            return "json"
        case .propertyList:
            return "xml"
        case .yaml:
            return "yaml"
        case .markdown:
            return "markdown"
        case .html:
            return "html"
        }
    }

    var mimeType: String {
        switch self {
        case .json:
            return "application/json"
        case .propertyList:
            return "application/x-plist"
        case .yaml:
            return "application/x-yaml"
        case .markdown:
            return "text/markdown"
        case .html:
            return "text/html"
        }
    }
}
