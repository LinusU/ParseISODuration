// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ParseISODuration",
    products: [
        .library(name: "ParseISODuration", targets: ["ParseISODuration"]),
    ],
    targets: [
        .target(name: "ParseISODuration", dependencies: []),
        .testTarget(name: "ParseISODurationTests", dependencies: ["ParseISODuration"]),
    ]
)
