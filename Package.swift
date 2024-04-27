// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECSharedModels",
    platforms: [
       .iOS(.v16),
       .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ECSharedModels",
            targets: ["ECSharedModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing.git", from: "0.6.0"),
        .package(url: "https://github.com/orlandos-nl/BSON.git", from: "8.1.0")
    ],
    targets: [
        .target(
            name: "ECSharedModels",
            dependencies: [
                .product(name: "URLRouting", package: "swift-url-routing"),
                .product(name: "BSON", package: "BSON")
            ]
        ),
        .testTarget(
            name: "ECSharedModelsTests",
            dependencies: ["ECSharedModels"]),
    ]
)
