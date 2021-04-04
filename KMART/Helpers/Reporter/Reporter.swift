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
            PrettyPrint.print(.info, string: "Generating report for \(report.identifier):", newLine: false)

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
            PrettyPrint.print(.info, prefix: false, string: String(format: " %.1f seconds", delta))
        }

        return reports
    }
}
