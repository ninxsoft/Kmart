//
//  Int+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 24/2/21.
//

import Foundation

extension Int {
    static let defaultOption: Int = 15
    static let maximumScriptSize: Int = 32 * 1_024
    var digits: Int {
        numberOfDigits(in: self)
    }

    /// Returns the number of digits in a given integer.
    ///
    /// - Parameters:
    ///   - number: The integer to validate.
    /// - Returns: An integer containing the number of digits.
    private func numberOfDigits(in number: Int) -> Int {
        abs(number) >= 0 && abs(number) < 10 ? 1 : 1 + numberOfDigits(in: number / 10)
    }
}
