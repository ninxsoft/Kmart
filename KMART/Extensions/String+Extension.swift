//
//  String+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation

extension String {
    static let appName: String = "kmart"
    static let identifier: String = "com.ninxsoft.\(appName)"
    static let abstract: String = "Kick-Ass Mac Admin Reporting Tool"
    static let discussion: String = "Generate kick-ass Jamf Pro reports."

    func escapingMarkdown() -> String {
        self.replacingOccurrences(of: "[", with: "\\[")
            .replacingOccurrences(of: "]", with: "\\]")
            .replacingOccurrences(of: "|", with: "\\|")
            .replacingOccurrences(of: "_", with: "\\_")
    }
}
