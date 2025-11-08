import Foundation
import Dependencies

extension DependencyValues {
    var service: Service {
        get { self[Service.self] }
        set { self[Service.self] = newValue }
    }
}

struct Service: DependencyKey, Sendable {
    
    static let liveValue: Self = .init(
        event: EventServiceImpl(),
        project: ProjectServiceImpl()
    )
    
    let event: any EventService
    let project: any ProjectService
    
}
