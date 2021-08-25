//
//  Shell.swift
//  KMART
//
//  Created by Nindi Gill on 30/3/21.
//

import Foundation

struct Shell {

    static func shellcheck(_ inputData: Data, level: LintLevel) -> [Lint]? {
        let process: Process = Process()
        let inputPipe: Pipe = Pipe()
        let url: URL = URL(fileURLWithPath: "\(NSTemporaryDirectory())\(String.identifier).\(UUID().uuidString)")

        if inputData.count > Int.maximumScriptSize {
            do {
                try inputData.write(to: url)
                process.arguments = ["--severity", "warning", "--format", "json1", url.path]
            } catch {
                PrettyPrint.print(.error, string: "\(error.localizedDescription)")
                return nil
            }
        } else {
            inputPipe.fileHandleForWriting.write(inputData)
            inputPipe.fileHandleForWriting.closeFile()
            process.arguments = ["-", "--severity", "warning", "--format", "json1"]
        }

        let outputPipe: Pipe = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/local/bin/shellcheck")
        process.standardInput = inputPipe
        process.standardOutput = outputPipe

        do {
            try process.run()
            process.waitUntilExit()

            if inputData.count > Int.maximumScriptSize {
                try FileManager.default.removeItem(at: url)
            }

            let outputData: Data = outputPipe.fileHandleForReading.readDataToEndOfFile()

            guard let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: outputData, options: []) as? [String: Any],
                let array: [[String: Any]] = dictionary["comments"] as? [[String: Any]] else {
                return nil
            }

            let data: Data = try JSONSerialization.data(withJSONObject: array, options: [])
            let lints: [Lint] = try JSONDecoder().decode([Lint].self, from: data).filter { $0.level == level && $0.code != 1071 } // https://github.com/koalaman/shellcheck/wiki/SC1071
            return lints
        } catch {
            PrettyPrint.print(.error, string: "\(error.localizedDescription)")
            return nil
        }
    }
}
