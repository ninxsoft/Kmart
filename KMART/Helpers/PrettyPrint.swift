//
//  PrettyPrint.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct PrettyPrint {

    static func printHeader(_ header: String) {
        let horizontal: String = String(repeating: "─", count: header.count + 2)
        let string: String = "┌\(horizontal)┐\n│ \(header) │\n└\(horizontal)┘"
        Swift.print(string.color(.blue))
    }

    static func print(_ string: String, prefix: String = "  ├─ ", terminator: String = "\n") {
        let string: String = "\(prefix.color(.green))\(string)"
        Swift.print(string, terminator: terminator)
    }
}
