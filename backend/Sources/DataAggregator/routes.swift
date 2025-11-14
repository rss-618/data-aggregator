import Fluent
import Vapor
import JWT

func routes(_ app: Application) throws {
    // React Controller
    try app.register(collection: ReactController(publicDirectory: app.directory.publicDirectory))
    // Auth Controller
    try app.register(collection: AuthenticationController())
    // Protected
    let protected = app.grouped(TokenAuthenticator(type: .access), JWTToken.guardMiddleware())
    try protected.register(collection: EventController())
    try protected.register(collection: ProjectController())
}

