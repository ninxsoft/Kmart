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
}
