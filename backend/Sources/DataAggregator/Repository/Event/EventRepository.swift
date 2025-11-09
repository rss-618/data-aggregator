import Fluent
import Vapor

protocol EventRepository: Sendable {
    
    func getAll(on database: any Database) async throws -> [EventModel]

    func add(_ request: EventModel, on database: any Database) async throws
    
    func find(_ id: UUID, on database: any Database) async throws -> EventModel?
    
    func update(_ content: EventModel, on database: any Database) async throws
    
    func delete(_ id: UUID, on database: any Database) async throws
    
}
