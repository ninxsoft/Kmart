// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// Package configuration
let package = Package(
    name: "KMART",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "kmart", targets: ["KMART"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.3"),
        .package(url: "https://github.com/jpsim/Yams", from: "5.0.1"),
        .package(url: "https://github.com/drmohundro/SWXMLHash", from: "7.0.0"),
        .package(url: "https://github.com/JohnSundell/Ink", from: "0.5.1")
    ],
    targets: [
        .executableTarget(
            name: "KMART",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Yams", package: "Yams"),
                .product(name: "SWXMLHash", package: "SWXMLHash"),
                .product(name: "Ink", package: "Ink")
            ],
            path: "KMART"
        )
    ]
)
