// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TLDR",
    dependencies: [
        .package(url: "https://github.com/AparokshaUI/Adwaita", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "TLDR",
            dependencies: [
                .product(name: "Adwaita", package: "Adwaita")
            ],
            path: "Sources"
        )
    ]
)