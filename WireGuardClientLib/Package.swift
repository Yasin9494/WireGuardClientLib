import PackageDescription

let package = Package(
    name: "WireGuardClientLib",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "WireGuardClientLib",
            targets: ["WireGuardClientLib"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WireGuardClientLib",
            dependencies: [],
            path: "Sources/WireGuardClientLib"
        ),
        .testTarget(
            name: "WireGuardClientLibTests",
            dependencies: ["WireGuardClientLib"],
            path: "Tests/WireGuardClientLibTests"
        ),
    ]
)
