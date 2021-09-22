//
//  Sequence+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 15/2/21.
//

import Foundation

extension Sequence where Iterator.Element == [String: Any] {

    var identifiers: [Int] {
        self.compactMap { $0["id"] as? Int }
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
