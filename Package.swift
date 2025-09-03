// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Flyreel",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Flyreel",
            targets: ["FlyreelTargets"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Flyreel/flyreel-camera-ios", exact: "0.0.2"),
        .package(url: "https://github.com/Flyreel/flyreel-fnol-ios", exact: "0.0.2"),
        .package(url: "https://github.com/Flyreel/flyreel-panorama-ios", exact: "0.0.6"),
    ],
    targets: [
        .binaryTarget(
            name: "Flyreel",
            path: "Flyreel.xcframework"
        ),
        .target(
            name: "FlyreelTargets",
            dependencies: [
                .target(name: "Flyreel"),
                .product(name: "FlyreelCamera", package: "flyreel-camera-ios"),
                .product(name: "FlyreelFNOL", package: "flyreel-fnol-ios"),
                .product(name: "FlyreelPanorama", package: "flyreel-panorama-ios"),
            ],
            path: "Sources"
        ),
    ]
)
