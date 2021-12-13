//
//  PrettyPrint.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

/// Struct used to perform all **PrettyPrint** operations.
struct PrettyPrint {

    /// Prints a header wuth a colored border.
    ///
    /// - Parameters:
    ///   - header: The header string to print.
    static func printHeader(_ header: String) {
        let horizontal: String = String(repeating: "─", count: header.count + 2)
        let string: String = "┌\(horizontal)┐\n│ \(header) │\n└\(horizontal)┘"
        Swift.print(string.color(.blue))
    }

    /// Prints a string with an optional prefix and terminator.
    ///
    /// - Parameters:
    ///   - string:     The string to print.
    ///   - prefix:     The custom string to prepend.
    ///   - terminator: The custom string used as a terminator.
    static func print(_ string: String, prefix: String = "  ├─ ", terminator: String = "\n") {
        let string: String = "\(prefix.color(.green))\(string)"
        Swift.print(string, terminator: terminator)
    }
}
