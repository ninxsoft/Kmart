//
//  Sequence+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

extension Sequence where Iterator.Element == [String: Any] {

    var identifiers: [Int] {

        var identifiers: [Int] = []

        forEach {
            if let string: String = $0["id"] as? String,
                let id: Int = Int(string) {
                identifiers.append(id)
            } else if let id: Int = $0["id"] as? Int {
                identifiers.append(id)
            }
        }

        return identifiers
    }

    var names: [String] {
        self.compactMap { $0["name"] as? String }
    }

    func replacingCodeType() -> [[String: Any]] {

        var dictionaries: [[String: Any]] = []

        forEach {
            if let code: Int = $0["code"] as? Int {
                var dictionary: [String: Any] = $0
                dictionary["code"] = String(code)
                dictionaries.append(dictionary)
            }
        }

        return dictionaries
    }
}
