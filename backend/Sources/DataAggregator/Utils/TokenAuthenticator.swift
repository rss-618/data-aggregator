import JWT
import Foundation
import Vapor
import Fluent

struct TokenAuthenticator: JWTAuthenticator {
    
    let type: TokenType
    
    func authenticate(jwt: JWTToken, for request: Request) async throws {
        request.auth.login(jwt)

        guard try await BlacklistedTokenModel
            .query(on: request.db)
            .filter(\.$tokenId == jwt.id)
            .first() == nil else {
            throw JWTError.generic(identifier: "invalid", reason: "token revoked")
        }
        guard jwt.type == type else {
            throw JWTError.generic(identifier: "invalid", reason: "incorrect JWT token")
        }
    }
    
}
