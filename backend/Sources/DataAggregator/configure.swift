import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) async throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.databases.use(
        DatabaseConfigurationFactory.postgres(
            configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "username",
        password: Environment.get("DATABASE_PASSWORD") ?? "password",
        database: Environment.get("DATABASE_NAME") ?? "database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ),
        as: .psql
    )

    app.migrations.add(CreateDeviceTable(), to: .psql)
    app.migrations.add(CreateUserTable(), to: .psql)
    app.migrations.add(CreateProjectTable(), to: .psql)
    app.migrations.add(CreateEventTable(), to: .psql)
    app.migrations.add(CreateProjectUserPivotTable(), to: .psql)
    
    try await app.autoMigrate()

    /* Setup CORS for external calls */
//    app.middleware.use(
//        CORSMiddleware(
//            configuration: .init(
//                allowedOrigin: .all,
//                allowedMethods: [.GET,
//                                 .POST,
//                                 .PUT,
//                                 .OPTIONS,
//                                 .DELETE,
//                                 .PATCH],
//                allowedHeaders: [
//                  .accept,
//                  .authorization,
//                  .contentType,
//                  .origin,
//                  .xRequestedWith,
//                  .userAgent,
//                  .accessControlAllowOrigin
//                ]
//              )
//        ),
//        at: .beginning
//    )

    // register routes
    try routes(app)
}
