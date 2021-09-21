// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "World",
    products: [
        .library(
            name: "World",
            targets: ["World"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "World",
            dependencies: []
        ),
        .testTarget(
            name: "WorldTests",
            dependencies: ["World"]
        ),
    ]
)
