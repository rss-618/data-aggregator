import Fluent
import Foundation

final class BlacklistedTokenModel: Model, @unchecked Sendable {

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

extension BlacklistedTokenModel {
    struct Migration: AsyncMigration {
        func prepare(on database: any Database) async throws {
            try await database.schema(BlacklistedTokenModel.schema)
                .id()
                .field("token_id", .uuid, .required)
                .unique(on: "token_id")
                .field("expiration", .double, .required)
                .create()
        }

        func revert(on database: any Database) async throws {
            try await database.schema(EventModel.schema).delete()
        }
    }

}
