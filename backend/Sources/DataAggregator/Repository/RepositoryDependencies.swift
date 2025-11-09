import Foundation
import Dependencies

extension DependencyValues {
    var repository: Repository {
        get { self[Repository.self] }
        set { self[Repository.self] = newValue }
    }
}

struct Repository: DependencyKey, Sendable {
    static let liveValue: Repository = .init(
        event: EventRepositoryImpl(),
        project: ProjectRepositoryImpl()
    )
    
    let event: any EventRepository
    let project: any ProjectRepository
}
