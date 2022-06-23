<p>
  <img src="https://img.shields.io/badge/Swift-5.7-f05318.svg" />
  <img src="https://img.shields.io/badge/iOS->= 13.0-blue.svg" />
  <img src="https://img.shields.io/badge/macOS->= 10.15-blue.svg" />
  <img src="https://img.shields.io/badge/watchOS->= 6.0-blue.svg" />
  <img src="https://img.shields.io/badge/tvOS->= 13.0-blue.svg" />
  <img alt="GitHub" src="https://img.shields.io/github/license/lukepistrol/SwiftLintPlugin">
  <a href="https://twitter.com/lukeeep_">
    <img src="https://img.shields.io/badge/Twitter-@lukeeep_-1e9bf0.svg?style=flat" alt="Twitter: @lukeeep_" />
  </a>
</p>

# SwiftLintPlugin

A SPM Plugin for [SwiftLint](https://github.com/realm/SwiftLint/).

Implementation discussed [here](https://github.com/realm/SwiftLint/issues/3840#issuecomment-1085699163).

> ⚠️ This requires `Swift 5.7` and though might not work in current CI/CD workflows.

## Add to Package

First add a dependency from this package:

```swift
dependencies: [
    // ...
    .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.0.1"),
]
```

Then add it to your targets as a plugin:

```swift
targets: [
    .target(
        name: "YOUR_TARGET",
        dependencies: [],
        plugins: [
            .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
        ]
    ),
]
```
