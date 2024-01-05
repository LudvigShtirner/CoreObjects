// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

struct RemotePackage {
    let name: String
    let productName: String
    let url: String
    
    init(name: String,
         productName: String? = nil,
         url: String) {
        self.name = name
        self.productName = productName ?? name
        self.url = url
    }
}

private let coreObjects = "CoreObjects"
private let coreObjectsTests = "CoreObjectsTests"

private let supportCode = RemotePackage(name: "SupportCode",
                                        url: "https://github.com/LudvigShtirner/SupportCode.git")

let package = Package(
    name: coreObjects,
    platforms: [.iOS(.v15)],
    products: [
        .library(name: coreObjects, targets: [coreObjects]),
    ],
    dependencies: [
        .package(url: supportCode.url, branch: "main")
    ],
    targets: [
        .target(
            name: coreObjects,
            dependencies: [
                .byName(name: supportCode.name)
            ]),
        .testTarget(
            name: coreObjectsTests,
            dependencies: [
                .byName(name: coreObjects)
            ]),
    ]
)
