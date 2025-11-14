import Vapor
import JWT

struct JWTToken: Authenticatable, JWTPayload {
    
    var id: UUID = UUID()
    var userId: UUID
    var type: TokenType
    var expiration: ExpirationClaim

    init(userId: UUID, type: TokenType, time: TimeInterval.Time) {
        self.userId = userId
        self.type = type
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(time.interval))
    }

    init(with user: UserModel, type: TokenType, time: TimeInterval.Time) throws {
        self.init(userId: try user.requireID(), type: type, time: time)
    }

    func verify(using algorithm: some JWTAlgorithm) throws {
        try expiration.verifyNotExpired()
    }
}
