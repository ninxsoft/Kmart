//
//  Double+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 24/2/21.
//

import Foundation

extension Double {

    func daysSince(_ toDate: Date) -> Int {
        let fromDate: Date = Date(timeIntervalSince1970: self)
        let components: DateComponents = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
        return components.day ?? -1
    }
}
