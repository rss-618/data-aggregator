import Fluent
import Foundation

final class BlacklistedToken: Model, @unchecked Sendable {
    

    static let schema = "blacklisted+token"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "token_id")
    var tokenId: UUID
    @Timestamp(key: "expiration", on: .none, format: .unix)
    var expiration: Date?
    
    init() {}
    
    public init(id: UUID? = nil, tokenId: UUID, expiration: Date) {
        self.id = id
        self.tokenId = tokenId
        self.expiration = expiration
    }
}
