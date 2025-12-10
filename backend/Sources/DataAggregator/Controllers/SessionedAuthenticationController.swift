import Fluent
import Vapor
import Fluent

struct SessionedAuthenticationController: RouteCollection {
    
    static let group: PathComponent = "auth"
    
    enum AuthError: Error {
        case userNotFound
    }
    
    func boot(routes: any RoutesBuilder) throws {
        let auth = routes.grouped(Self.group)
        
        auth.get("logout") { req in
            logout(req)
            return Response(status: .ok)
        }
        
        auth
            .grouped(
                UserModel.credentialsAuthenticator(),
            )
            .post("login") { req in
                let user = try req.auth.require(UserModel.self)
                logout(req)
                req.session.authenticate(user)
                // TODO: Make refresh expiration settable through other means. I dont like where this currently is.
                req.session.data.expiration = .intervalFromNow(.days(30))

                guard let dbModel = try await UserModel.query(on: req.db).filter(\.$username == user.username).first() else {
                    throw AuthError.userNotFound
                }
                return UserResponse(dbModel)
            }
        
        auth.post("register") { req in
            logout(req)
            let content = try req.content.decode(RegisterRequest.self)
            let password = try await req.password.async.hash(content.password)
            try await UserModel(username: content.username, passwordHash: password)
                .save(on: req.db)
            return Response(status: .ok)
        }
    }
    
    func logout(_ request: Request) {
        guard request.session.authenticated(UserModel.self) != nil else {
            return
        }
        request.auth.logout(UserModel.self)
        request.session.destroy()
    }
    
    // TODO: Move this to a sessionless controller
//    func generateNewJWTTokens(userId: UUID, req: Request) async throws -> ClientTokenResponse {
//        let accessToken = JWTToken(userId: userId, type: .access, time: .hour(1))
//        let refreshToken = JWTToken(userId: userId, type: .refresh, time: .days(1))
//        return try await ClientTokenResponse(
//            accessToken: req.jwt.sign(accessToken),
//            refreshToken: req.jwt.sign(refreshToken)
//        )
//    }
    
}
