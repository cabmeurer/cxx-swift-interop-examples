// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cxx_Interop",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "Cxx",
            targets: ["Cxx"]),
        .executable(
            name: "Cxx_Interop",
            targets: ["Cxx_Interop"]),
    ],
    targets: [
        
        .target(
            name: "Cxx",
            dependencies: []
        ),
        .executableTarget(
            name: "Cxx_Interop",
            dependencies: ["Cxx"],
            path: "./Sources/Cxx_Interop",
            sources: [ "main.swift" ],
            swiftSettings: [.unsafeFlags([
                "-I", "Sources/Cxx"
            ])]
        ),
    ]
)
