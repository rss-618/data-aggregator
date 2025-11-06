import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) async throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "postgres",
        password: Environment.get("DATABASE_PASSWORD") ?? "test_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    app.migrations.add(CreateEvent(), to: .psql)
    
    try await app.autoMigrate()

    /* Setup CORS for external calls */
    app.middleware.use(
        CORSMiddleware(
            configuration: .init(
                allowedOrigin: .all,
                allowedMethods: [.GET,
                                 .POST,
                                 .PUT,
                                 .OPTIONS,
                                 .DELETE,
                                 .PATCH],
                allowedHeaders: [
                  .accept,
                  .authorization,
                  .contentType,
                  .origin,
                  .xRequestedWith,
                  .userAgent,
                  .accessControlAllowOrigin
                ]
              )
        ),
        at: .beginning
    )

    // register routes
    try routes(app)
}
