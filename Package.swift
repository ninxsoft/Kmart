// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KMART",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(name: "kmart", targets: ["KMART"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.4"),
        .package(url: "https://github.com/jpsim/Yams", from: "4.0.6"),
        .package(url: "https://github.com/JohnSundell/Ink", from: "0.5.1"),
        .package(name: "SwiftSMTP", url: "https://github.com/Kitura/Swift-SMTP", from: "5.1.200")
    ],
    targets: [
        .target(name: "KMART", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "Yams", package: "Yams"),
            .product(name: "Ink", package: "Ink"),
            .product(name: "SwiftSMTP", package: "SwiftSMTP")
        ], path: "KMART")
    ]
)
