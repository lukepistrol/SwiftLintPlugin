//
//  main.swift
//  Plugins/SwiftLint
//
//  Created by Lukas Pistrol on 23.06.22.
//
//  Big thanks to @marcoboerner on GitHub
//  https://github.com/realm/SwiftLint/issues/3840#issuecomment-1085699163
//

import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        return buildCommands(
            workingDirectory: context.pluginWorkDirectory,
            packageDirectory: context.package.directory,
            targetDirectory: target.directory,
            tool: try context.tool(named: "swiftlint")
        )
    }

    private func buildCommands(
        workingDirectory: Path,
        packageDirectory: Path,
        targetDirectory: Path,
        tool: PluginContext.Tool
    ) -> [Command] {
        // If the DISABLE_SWIFTLINT environment variable is set, don't run SwiftLint.
        if ProcessInfo.processInfo.environment["DISABLE_SWIFTLINT"] != nil {
            return []
        }

        var arguments = [
            "lint",
            "--config",
            "\(packageDirectory.string)/.swiftlint.yml",
        ]

        // If running in Xcode Cloud, disable caching.
        if ProcessInfo.processInfo.environment["CI_XCODE_CLOUD"] == "TRUE" {
            arguments.append("--no-cache")
        } else {
            arguments.append("--cache-path")
            arguments.append("\(workingDirectory)")
        }

        arguments.append(targetDirectory.string)

        return [
            .prebuildCommand(
                displayName: "Running SwiftLint for \(targetDirectory.lastComponent)",
                executable: tool.path,
                arguments: arguments,
                outputFilesDirectory: workingDirectory.appending("Output")
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftLintPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        return buildCommands(
            workingDirectory: context.pluginWorkDirectory,
            packageDirectory: context.xcodeProject.directory,
            targetDirectory: context.xcodeProject.directory,
            tool: try context.tool(named: "swiftlint")
        )
    }
}
#endif
