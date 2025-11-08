import Fluent
import Foundation

final class UserModel: Model, @unchecked Sendable {
    static let schema = "user"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "username")
    var username: String
    @Field(key: "password")
    var password: String
    @Field(key: "first_name")
    var firstName: String
    @Field(key: "last_name")
    var lastName: String
    @Timestamp(key: "created", on: .create, format: .unix)
    var created: Date?
    @Siblings(
        through: ProjectUserPivotTable.self,
        from: \.$user,
        to: \.$project
    )
    var tables: [ProjectModel]

    public init() {}
    
    public init(
        id: UUID? = nil,
        username: String,
        password: String,
        firstName: String,
        lastName: String,
        created: Date? = nil,
        tables: [ProjectModel]
    ) {
        self.id = id
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.created = created
        self.tables = tables
    }
}
