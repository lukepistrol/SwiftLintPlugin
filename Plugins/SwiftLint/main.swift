//
//  main.swift
//  Plugins/SwiftLint
//
//  Created by Lukas Pistrol on 23.06.22.
//
//  Big thanks to @marcoboerner on GitHub
//  https://github.com/realm/SwiftLint/issues/3840#issuecomment-1085699163
//

import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        return [
            .buildCommand(
                displayName: "Running SwiftLint for \(target.name)",
                executable: try context.tool(named: "swiftlint").path,
                arguments: [
                    "lint",
                    "--in-process-sourcekit",
                    "--path",
                    target.directory.string,
                    "--config",
                    "\(context.package.directory.string)/.swiftlint.yml"
                ],
                environment: [:]
            )
        ]
    }
}
