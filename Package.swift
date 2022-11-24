// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Toolkit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Toolkit",
            targets: [
                "Toolkit"
            ]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .upToNextMajor(from: "0.9.2")),
    ],
    targets: [
        .target(
            name: "Toolkit",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift")])
    ]
)
