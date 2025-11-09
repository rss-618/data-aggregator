import Fluent

struct CreateUserTable: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(UserModel.schema)
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("first_name", .string)
            .field("last_name", .string)
            .field("created", .double)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(UserModel.schema).delete()
    }
}
