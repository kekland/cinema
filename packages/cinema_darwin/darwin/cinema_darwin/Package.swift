// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cinema_darwin",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15"),
    ],
    products: [
        .library(name: "cinema-darwin", targets: ["cinema_darwin"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "cinema_darwin",
            dependencies: [
                .target(name: "cinema_darwin_bindings"),
                .target(name: "cinema_ios", condition: .when(platforms: [.iOS])),
                .target(name: "cinema_macos", condition: .when(platforms: [.macOS])),
            ]
        ),
        .target(
            name: "cinema_ios",
            path: "Sources/cinema_ios",
            packageAccess: true
        ),
        .target(
            name: "cinema_macos",
            path: "Sources/cinema_macos",
            packageAccess: true
        ),
        .target(
            name: "cinema_darwin_bindings",
            path: "Sources/cinema_darwin_bindings",
            publicHeadersPath: "."
        ),
    ]
)
