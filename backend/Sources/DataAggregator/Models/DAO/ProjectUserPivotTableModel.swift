import Fluent
import Foundation

enum ProjectUserRole: String, Codable {
    case owner
    case admin
    case guest
}

final class ProjectUserPivotTableModel: Model, @unchecked Sendable {
    static let schema = "project+user"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "project_id")
    var project: ProjectModel

    @Parent(key: "user_id")
    var user: UserModel

    @Timestamp(key: "date_linked", on: .create, format: .unix)
    var created: Date?

    @Enum(key: "status")
    var status: ProjectUserRole

    init() { }
    
    init(
        id: UUID? = nil,
        project: ProjectModel,
        user: UserModel,
        created: Date? = nil,
        status: ProjectUserRole
    ) throws {
        self.id = id
        self.$project.id = try project.requireID()
        self.$user.id = try user.requireID()
        self.created = created
        self.status = status
    }
    
}

extension ProjectUserPivotTableModel {
    struct Migration: AsyncMigration {
        func prepare(on database: any Database) async throws {
            try await database.schema(ProjectUserPivotTableModel.schema)
                .id()
                .field("project_id", .uuid, .required, .references(ProjectModel.schema, "id"))
                .field("user_id", .uuid, .required, .references(UserModel.schema, "id"))
                .unique(on: "project_id", "user_id")
                .field("created", .double)
                .field("status", .string, .required)
                .create()
        }

        func revert(on database: any Database) async throws {
            try await database.schema(ProjectUserPivotTableModel.schema).delete()
        }
    }
}
