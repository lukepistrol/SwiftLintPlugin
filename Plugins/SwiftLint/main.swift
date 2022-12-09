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

protocol Helper: AnyObject {}

class PluginHelper: Helper {
    static let bundle = Bundle(for: PluginHelper.self)
}

@main
struct SwiftLintPlugin: BuildToolPlugin {
    
    class Plugin {}
    static var bundle: Bundle { return Bundle(for: SwiftLintPlugin.Plugin.self) }
    
    enum Xcode {
        case package, project
    }
    
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        downloadSwiftLintConfiguration(for: .package)
        
        let url = SwiftLintPlugin.bundle.url(forResource: "swiftlint_package", withExtension: "yml")
        let urlText = SwiftLintPlugin.bundle.url(forResource: "demo", withExtension: "txt")
        
        let fileManager = FileManager.default
        
        // Get the URL of the plugin's directory
        let pluginURL = fileManager.urls(for: .libraryDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Application Support")
            .appendingPathComponent("YourPluginName")
        
        // Construct the URL of the YAML file
        let ymlURL = pluginURL.appendingPathComponent("swiftlint_package.yml")

        print("❤️❤️❤️ URL: \(url)")
        print("❤️❤️❤️ URL: \(ymlURL)")

        let outputDir = context.pluginWorkDirectory.appending("Gir2SwiftOutputDir")
        try FileManager.default.createDirectory(atPath: outputDir.string, withIntermediateDirectories: true)
        
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
    
    fileprivate func downloadSwiftLintConfiguration(for xcodeConfig: Xcode) {
        switch xcodeConfig {
        case .package:
            search(for: "swiftlint_package.yml")
        case .project:
            search(for: "swiftlint_package.yml")
        }
    }
    
    private func search(for filename: String) {
        let currentDirectoryPath = FileManager.default.currentDirectoryPath
        let fileURL = URL(fileURLWithPath: "\(currentDirectoryPath)/Plugins/Resources/\(filename)")
        print("❌❌ FILE URL: \(fileURL)")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let fileContents = try String(contentsOf: fileURL)
                try fileContents.write(toFile: ".swiftlint.yml", atomically: true, encoding: .utf8)
                let destinationURL = URL(fileURLWithPath: "\(currentDirectoryPath)/")
                try fileContents.write(to: destinationURL, atomically: true, encoding: .utf8)
                print("FILE SAVE: \(destinationURL)")
            } catch {
                print("❌❌ Error reading or writing file: \(error)")
            }
        } else {
            print("❌❌ File does not exist at specified URL")
        }
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftLintPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        downloadSwiftLintConfiguration(for: .project)
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
