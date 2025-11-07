import Fluent
import Vapor

func routes(_ app: Application) throws {
    // React Controller
    try app.register(collection: ReactController(publicDirectory: app.directory.publicDirectory))
    // Api Controllers
    try app.register(collection: EventController(repository: .default))
    try app.register(collection: ProjectController(repository: .default))
}
