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
import Foundation

@available(macOS 12.0, *)
@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        return [
            .buildCommand(
                displayName: "Running SwiftLint for \(target.name)",
                executable: try context.tool(named: "swiftlint").path,
                arguments: [
                    "lint",
                    "--config",
                    "\(context.package.directory.string)/.swiftlint.yml",
                    "--cache-path",
                    "\(context.pluginWorkDirectory.string)/cache",
                    target.directory.string
                ],
                environment: [:]
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

@available(macOS 12.0, *)
extension SwiftLintPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        return [
            .buildCommand(
                displayName: "Running SwiftLint for \(target.displayName)",
                executable: try context.tool(named: "swiftlint").path,
                arguments: [
                    "lint",
                    "--config",
                    "\(context.xcodeProject.directory.string)/.swiftlint.yml",
                    "--cache-path",
                    "\(context.pluginWorkDirectory.string)/cache",
                    context.xcodeProject.directory.string
                ],
                environment: [:]
            )
        ]
    }
}
#endif
