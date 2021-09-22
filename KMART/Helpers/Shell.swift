//
//  Shell.swift
//  KMART
//
//  Created by Nindi Gill on 30/3/21.
//

import Foundation

struct Shell {

    static func lintCheck(_ inputData: Data, type scriptType: ScriptType, level: LintLevel) -> [Lint] {

        switch scriptType {
        case .shell:
            return shellcheck(inputData, level: level)
        case .python:
            return flake8(inputData, level: level)
        }
    }

    private static func shellcheck(_ inputData: Data, level: LintLevel) -> [Lint] {

        let process: Process = Process()
        let inputPipe: Pipe = Pipe()
        let url: URL = URL(fileURLWithPath: "\(NSTemporaryDirectory())\(String.identifier).\(UUID().uuidString)")

        if inputData.count > Int.maximumScriptSize {
            do {
                try inputData.write(to: url)
                process.arguments = ["--severity", "warning", "--format", "json1", url.path]
            } catch {
                PrettyPrint.print(error.localizedDescription)
                return []
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
                return []
            }

            let data: Data = try JSONSerialization.data(withJSONObject: array.replacingCodeType(), options: [])
            let lints: [Lint] = try JSONDecoder().decode([Lint].self, from: data).filter { $0.level == level && $0.code != "1071" } // https://github.com/koalaman/shellcheck/wiki/SC1071
            return lints
        } catch {
            PrettyPrint.print(error.localizedDescription)
            return []
        }
    }

    private static func flake8(_ inputData: Data, level: LintLevel) -> [Lint] {
        let inputPipe: Pipe = Pipe()
        inputPipe.fileHandleForWriting.write(inputData)
        inputPipe.fileHandleForWriting.closeFile()
        let outputPipe: Pipe = Pipe()
        let process: Process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/local/bin/flake8")
        process.arguments = ["-"]
        process.standardInput = inputPipe
        process.standardOutput = outputPipe

        do {
            try process.run()
            process.waitUntilExit()
            let outputData: Data = outputPipe.fileHandleForReading.readDataToEndOfFile()

            guard let string: String = String(data: outputData, encoding: .utf8) else {
                return []
            }

            let array: [[String: Any]] = string.lintArray()
            let data: Data = try JSONSerialization.data(withJSONObject: array, options: [])
            let lints: [Lint] = try JSONDecoder().decode([Lint].self, from: data).filter { $0.level == level }
            return lints
        } catch {
            PrettyPrint.print(error.localizedDescription)
            return []
        }
    }
}
