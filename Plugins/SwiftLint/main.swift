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

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        await downloadSwiftLintYamlFile()
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
    
    private func downloadSwiftLintYamlFile() async {
        do {
            let fileURL = "https://vishwaiosdev.github.io/images-repo/swiftlint.yml"
            guard let url = URL(string: fileURL) else { return }
            let request = URLRequest(url: url)
            let (dataFileUrl, _) = try await URLSession.shared.download(for: request)
            print("FILE URL: \(dataFileUrl)")
        } catch {
            debugPrint("Failed to download: \(error.localizedDescription)")
        }
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

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
