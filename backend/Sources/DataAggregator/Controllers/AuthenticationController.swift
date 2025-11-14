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
                return try await generateNewTokens(userId: user.requireID(), req: req)
            }
        
        auth
            .get("refresh") { req in
                let refreshToken = try req.content.decode(RefreshTokenRequest.self).refreshToken
                // Check if is valid refresh token
                let parsedToken: JWTToken = try await req.jwt.verify(refreshToken)
                try await TokenAuthenticator(type: .refresh)
                    .authenticate(jwt: parsedToken, for: req)
                // Add to blacklist TODO: Make scheduled db cleaning of expired blacklisted tokens
                try await BlacklistedToken(tokenId: parsedToken.id,
                                     expiration: parsedToken.expiration.value)
                    .save(on: req.db)
                
                // Return new tokens
                return try await generateNewTokens(userId: parsedToken.userId, req: req)
            }
        
        auth.post("register") { req in
            let content = try req.content.decode(RegisterRequest.self)
            let password = try await req.password.async.hash(content.password)
            try await UserModel(username: content.username, passwordHash: password)
                .save(on: req.db)
            return Response(status: .ok)
        }
    }
    
    func generateNewTokens(userId: UUID, req: Request) async throws -> ClientTokenResponse {
        let accessToken = JWTToken(userId: userId, type: .access, time: .hour(1))
        let refreshToken = JWTToken(userId: userId, type: .refresh, time: .days(1))
        return try await ClientTokenResponse(
            accessToken: req.jwt.sign(accessToken),
            refreshToken: req.jwt.sign(refreshToken)
        )
    }
    
}
