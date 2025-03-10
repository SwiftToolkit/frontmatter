// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "frontmatter",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "Frontmatter", targets: ["Frontmatter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.3.1")
    ],
    targets: [
        .target(
            name: "Frontmatter",
            dependencies: [
                .product(name: "Yams", package: "yams")
            ]
        ),
        .testTarget(name: "frontmatterTests", dependencies: ["Frontmatter"]),
    ]
)
