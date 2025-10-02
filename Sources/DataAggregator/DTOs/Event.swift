import Fluent
import Vapor

struct Event: Content {
    var id: UUID?
    var parameter: String
    var value: String
    
    func toModel() -> EventModel {
        .init(id: id, parameter: parameter, value: value)
    }
}
