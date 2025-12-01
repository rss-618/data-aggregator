import Fluent
import Vapor
import JWT
import Foundation

final class UserModel: Model,
                       @unchecked Sendable,
                       ModelCredentialsAuthenticatable,
                       ModelSessionAuthenticatable {
    
    static let usernameKey: KeyPath<UserModel, Field<String>> = \.$username
    static let passwordHashKey: KeyPath<UserModel, Field<String>> = \.$passwordHash
    
    func verify(password: String) throws -> Bool {
        try Encryptor.Hasher().verify(password, created: self.passwordHash)
    }
    
    static let schema = "user"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "username")
    var username: String
    @Field(key: "password")
    var passwordHash: String
    @Field(key: "first_name")
    var firstName: String?
    @Field(key: "last_name")
    var lastName: String?
    @Timestamp(key: "created", on: .create, format: .unix)
    var created: Date?
    @Siblings(
        through: ProjectUserPivotTableModel.self,
        from: \.$user,
        to: \.$project
    )
    var tables: [ProjectModel]

    init() {}
    
    init(
        id: UUID? = nil,
        username: String,
        passwordHash: String,
        firstName: String? = nil,
        lastName: String? = nil,
        created: Date? = nil,
        tables: [ProjectModel]? = nil
    ) throws {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
        self.firstName = firstName
        self.lastName = lastName
        self.created = created
        self.$tables.value = tables
    }
}

extension UserModel {
    struct Migration: AsyncMigration {
        func prepare(on database: any Database) async throws {
            try await database.schema(UserModel.schema)
                .id()
                .field("username", .string, .required)
                .unique(on: "username")
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
}
