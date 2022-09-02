<p>
  <img src="https://img.shields.io/badge/Swift-5.6-f05318.svg" />
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

A Swift Package Plugin for [SwiftLint](https://github.com/realm/SwiftLint/) that will run SwiftLint on build time and show errors & warnings in Xcode.

Once SwiftLint offers their own implementation, this will be obsolete.

> Implementation proposed [here](https://github.com/realm/SwiftLint/issues/3840#issuecomment-1085699163) by [@marcoboerner](https://github.com/marcoboerner).

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

## Add to Project

Starting with Xcode 14, plugins can also work on Xcode Project's targets. To do so, simply add this package to your SPM dependencies in Xcode. After that open your `target's settings > Build Phases` and add `SwiftLint` to `Run Build Tool Plug-ins` like shown below:

<img width="285" alt="Screen Shot 2022-09-02 at 09 33 23" src="https://user-images.githubusercontent.com/9460130/188084164-49903dc4-39a4-42fc-aa6f-6c6a813a7239.png">

> You may need to enable & trust the plugin before you can actually run it during builds.

-----

<a href="https://www.buymeacoffee.com/lukeeep" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
