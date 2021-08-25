//
//  Reporter.swift
//  KMART
//
//  Created by Nindi Gill on 16/2/21.
//

import Foundation

struct Reporter {

    static func generateReports(from objects: Objects, using configuration: Configuration) -> Reports {
        var reports: Reports = Reports()

        for report in configuration.reports {
            let start: Date = Date()
            let startString: String = "Generating \(report.identifier)..."
            PrettyPrint.print(startString, terminator: "")

            switch report.group {
            case .common:
                ReporterCommon.update(&reports, with: report, from: objects)
            case .mac:
                ReporterMac.update(&reports, with: report, from: objects, options: configuration.reportOptions)
            case .mobile:
                ReporterMobile.update(&reports, with: report, from: objects, options: configuration.reportOptions)
            }

            let end: Date = Date()
            let delta: TimeInterval = end.timeIntervalSince(start)
            let endString: String = String(format: " %.1f seconds", delta)
            PrettyPrint.print(prefix: "", endString)
        }

        return reports
    }
}
