// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConnectToWifi",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "ConnectToWifi", targets: ["ConnectToWifi"])
    ],
    targets: [
        .target(name: "ConnectToWifi", dependencies: []),
        .testTarget(name: "ConnectToWifiTests", dependencies: ["ConnectToWifi"])
    ]
)
