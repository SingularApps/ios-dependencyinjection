// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "DependencyInjection",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]),
    ],
    targets: [
        .target(
            name: "DependencyInjection",
            dependencies: []),
        .testTarget(
            name: "DependencyInjectionTests",
            dependencies: ["DependencyInjection"]),
    ]
)
