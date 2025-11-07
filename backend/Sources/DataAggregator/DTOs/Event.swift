import Fluent
import Vapor

struct Event: Content {
    var id: UUID?
    var parameter: String
    var value: String
    
    init(id: UUID? = nil, parameter: String, value: String) {
        self.id = id
        self.parameter = parameter
        self.value = value
    }
    
    init(_ event: EventModel) {
        self.init(id: event.id, parameter: event.parameter, value: event.value)
    }
}
