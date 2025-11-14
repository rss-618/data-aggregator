import Fluent

struct CreateBlacklistedTokenTable: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(BlacklistedToken.schema)
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
