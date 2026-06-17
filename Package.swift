// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConnectToWifi",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "ConnectToWifi", targets: ["ConnectToWifi"])
    ],
    targets: [
        .target(name: "ConnectToWifi", dependencies: [], swiftSettings: [.swiftLanguageMode(.v5)]),
        .testTarget(name: "ConnectToWifiTests", dependencies: ["ConnectToWifi"], swiftSettings: [.swiftLanguageMode(.v5)])
    ]
)
