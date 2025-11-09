import Fluent
import Vapor
import Fluent

struct AuthenticationController: RouteCollection {
    
    static let group: PathComponent = "auth"
        
    func boot(routes: any RoutesBuilder) throws {
        let auth = routes.grouped(Self.group)

        auth
            .grouped(UserModel.credentialsAuthenticator(), UserModel.guardMiddleware())
            .get("login") { req in
                let user = try req.auth.require(UserModel.self)
                let token = try SessionToken(userId: user.requireID())
                return try await ClientTokenResponse(token: req.jwt.sign(token))
            }
        
        auth.post("register") { req in
            let content = try req.content.decode(RegisterRequest.self)
            let password = try await req.password.async.hash(content.password)
            try await UserModel(username: content.username, passwordHash: password)
                .save(on: req.db)
            return Response(status: .ok)
        }
    }

}
