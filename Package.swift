// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECardifySharedModels",
    platforms: [
       .iOS(.v16),
       .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ECardifySharedModels",
            targets: ["ECardifySharedModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing.git", from: "0.5.0"),
        .package(url: "https://github.com/orlandos-nl/BSON.git", from: "8.0.9")
    ],
    targets: [
        .target(
            name: "ECardifySharedModels",
            dependencies: [
                .product(name: "URLRouting", package: "swift-url-routing"),
                .product(name: "BSON", package: "BSON")
            ]
        ),
        .testTarget(
            name: "ECardifySharedModelsTests",
            dependencies: ["ECardifySharedModels"]),
    ]
)
