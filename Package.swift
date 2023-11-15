// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let coreObjects = "CoreObjects"
private let coreObjectsTests = "CoreObjectsTests"

private let supportCode = "SupportCode"
private let supportCodeURL = "https://github.com/LudvigShtirner/SupportCode.git"

let package = Package(
    name: coreObjects,
    platforms: [.iOS(.v13)],
    products: [
        .library(name: coreObjects,
                 targets: [coreObjects]),
    ],
    dependencies: [
        .package(url: supportCodeURL,
                 branch: "main")
    ],
    targets: [
        .target(
            name: coreObjects,
            dependencies: [
                .byName(name: supportCode)
            ]),
        .testTarget(
            name: coreObjectsTests,
            dependencies: [
                .byName(name: coreObjects)
            ]),
    ]
)
