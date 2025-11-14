import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import JWT

public func configure(_ app: Application) async throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    try app.databases.use(
        DatabaseConfigurationFactory.postgres(
            configuration: .init(
                hostname: Environment.require("DATABASE_HOST"),
                port: Environment.require("DATABASE_PORT", to: Int.self),
                username: Environment.require("DATABASE_USERNAME"),
                password: Environment.require("DATABASE_PASSWORD"),
                database: Environment.require("DATABASE_NAME"),
                tls: .prefer(try .init(configuration: .clientDefault)))
        ),
        as: .psql
    )
    
    app.migrations.add(CreateBlacklistedTokenTable(), to: .psql)
    app.migrations.add(CreateDeviceTable(), to: .psql)
    app.migrations.add(CreateUserTable(), to: .psql)
    app.migrations.add(CreateProjectTable(), to: .psql)
    app.migrations.add(CreateEventTable(), to: .psql)
    app.migrations.add(CreateProjectUserPivotTable(), to: .psql)
    
    try await app.autoMigrate()
    
    // Auth
    app.passwords.use(Encryptor.provider)
    try await app.jwt.keys.add(hmac: .init(stringLiteral: Environment.require("JWT_SECRET")),
                               digestAlgorithm: .sha512)
    
    
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

