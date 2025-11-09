import Fluent
import Vapor

// Will likely reverse proxy instead of doing this :shrug:
struct ReactController: RouteCollection {
    
    let publicDirectory: String
    
    func boot(routes: any RoutesBuilder) throws {
        routes.get { req async throws in
            return try await serveIndex(req)
        }
        routes.get("*") { req async throws in
            return try await serveIndex(req)
        }
    }
    
    func serveIndex(_ req: Request) async throws -> View {
        return try await req.view.render("\(publicDirectory)index.html")
    }
    
}
