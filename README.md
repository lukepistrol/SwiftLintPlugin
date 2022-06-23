# SwiftLintPlugin

A SPM Plugin for [SwiftLint](https://github.com/realm/SwiftLint/).

Implementation like discussed [here](https://github.com/realm/SwiftLint/issues/3840#issuecomment-1085699163).

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
