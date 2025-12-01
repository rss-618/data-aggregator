// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "DataAggregator",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        // 🗄 An ORM for SQL and NoSQL databases.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.9.0"),
        // 🐘 Fluent driver for Postgres.
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.8.0"),
        // Queues
        .package(url: "https://github.com/vapor-community/vapor-queues-fluent-driver", from: "3.1.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        // Dependency Injection Library
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.10.0"),
        // JWT
        .package(url: "https://github.com/vapor/jwt.git", from: "5.1.2"),

    ],
    targets: [
        .executableTarget(
            name: "DataAggregator",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "JWT", package: "jwt"),
                .product(name: "QueuesFluentDriver", package: "vapor-queues-fluent-driver"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "DataAggregatorTests",
            dependencies: [
                .target(name: "DataAggregator"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }
