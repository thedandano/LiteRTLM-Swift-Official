// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "LiteRTLMSwift",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "LiteRTLMSwift",
            targets: ["LiteRTLMSwift"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "CLiteRTLM",
            url: "https://github.com/thedandano/LiteRTLM-Swift/releases/download/v0.12.1/CLiteRTLM.xcframework.zip",
            checksum: "2036b80079b2ba58ad71997e59ec12ce0fdccfdb51fa26455fab351ac8c98a29"
        ),
        .target(
            name: "LiteRTLMSwift",
            dependencies: ["CLiteRTLM"],
            path: "Sources/LiteRTLMSwift"
        )
    ]
)
