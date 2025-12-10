import NIOSSL
import Fluent
import FluentPostgresDriver
import QueuesFluentDriver
import Vapor
import JWT

public func configure(_ app: Application) async throws {
    
    // MARK: Middleware
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // MARK: Sessions
    app.sessions.configuration.cookieName = "daggregator_session"
    // TODO: make access expiration handled via env or something else
    app.sessions.configuration.cookieFactory = { sessionID in
            .init(
                string: sessionID.string,
                expires: .intervalFromNow(.days(7)),
                isSecure: true,
                isHTTPOnly: true
            )
    }
    app.sessions.use(.fluent(.psql))
    
    // MARK: Database
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
    
    app.migrations.add(SessionRecord.migration)
    app.migrations.add(BlacklistedTokenModel.Migration(), to: .psql)
    app.migrations.add(DeviceModel.Migration(), to: .psql)
    app.migrations.add(UserModel.Migration(), to: .psql)
    app.migrations.add(ProjectModel.Migration(), to: .psql)
    app.migrations.add(EventModel.Migration(), to: .psql)
    app.migrations.add(ProjectUserPivotTableModel.Migration(), to: .psql)
    
    try await app.autoMigrate()
    
    // MARK: Queues
    app.queues.use(.fluent(preservesCompletedJobs: false))
    
    app.queues.schedule(SessionCleanupJob())
        .daily()
        .at(.midnight)
    
    
    try app.queues.startScheduledJobs()
    
    // MARK: Auth
    app.passwords.use(Encryptor.provider)
    try await app.jwt.keys.add(hmac: .init(stringLiteral: Environment.require("JWT_SECRET")),
                               digestAlgorithm: .sha512)
    
    
    /* Setup CORS for external calls */
    app.middleware.use(
        CORSMiddleware(
            configuration: .init(
                allowedOrigin: .custom("http://localhost:5173"), // needs to be configurable
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

