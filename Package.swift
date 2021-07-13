// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FetchRequests",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "FetchRequests",
            targets: ["FetchRequests"]
        ),
    ],
    targets: [
        .target(
            name: "FetchRequests",
            path: "FetchRequests",
            exclude: ["Tests"]
        ),
        .testTarget(
            name: "FetchRequestsTests",
            dependencies: ["FetchRequests"],
            path: "FetchRequests/Tests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
