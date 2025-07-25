// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MitotiMergedLibrary",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MitotiMergedLibrary",
            targets: ["MitotiMergedLibrary"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jrendel/SwiftKeychainWrapper.git", from: "4.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MitotiMergedLibrary",
            dependencies: ["SwiftKeychainWrapper"],
            resources:[.process("Resources")]),
    ]
)
