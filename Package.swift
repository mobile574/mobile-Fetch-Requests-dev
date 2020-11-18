// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FetchRequests",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5),
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
