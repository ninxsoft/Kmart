//
//  ParsableCommand+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 14/12/2021.
//

import ArgumentParser
import Foundation

@available(macOS 12.0, *)
protocol AsyncParsableCommand: ParsableCommand {
    mutating func runAsync() async throws
}

extension ParsableCommand {
    // optional collection 'arguments' is currently required
    // swiftlint:disable:next discouraged_optional_collection
    static func main(_ arguments: [String]? = nil) async {
        do {
            var command: ParsableCommand = try parseAsRoot(arguments)

            if #available(macOS 12.0, *),
                var asyncCommand: AsyncParsableCommand = command as? AsyncParsableCommand {
                try await asyncCommand.runAsync()
            } else {
                try command.run()
            }
        } catch {
            exit(withError: error)
        }
    }
}
