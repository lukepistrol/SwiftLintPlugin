// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SwiftLintPlugin",
    platforms: [
        .iOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15),
        .tvOS(.v13),
    ],
    products: [
        .plugin(
            name: "SwiftLint",
            targets: ["SwiftLint"]
        ),
        .plugin(
            name: "SwiftLintFix",
            targets: ["SwiftLintFix"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.50.0/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "fb93e474e5827940985093c9cd437f1a70e511b16d790fe0e4150ab25edefa3b"
        ),

        .plugin(
            name: "SwiftLint",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),

        .plugin(
            name: "SwiftLintFix",
            capability: .command(
                intent: .sourceCodeFormatting(),
                permissions: [.writeToPackageDirectory(reason: "Fixes fixable lint issues")]
            ),
            dependencies: ["SwiftLintBinary"]
        ),
    ]
)
