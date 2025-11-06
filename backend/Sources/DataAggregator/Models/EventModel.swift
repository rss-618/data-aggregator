import Fluent
import Foundation

final class EventModel: Model, @unchecked Sendable {
    static let schema = "event"
        
    @ID(key: .id)
    var id: UUID?

    @Field(key: "parameter")
    var parameter: String
    
    @Field(key: "value")
    var value: String

    init() { }
    
    convenience init(_ event: Event) {
        self.init(id: event.id, parameter: event.parameter, value: event.value)
    }

    init(
        id: UUID? = nil,
        parameter: String,
        value: String
    ) {
        self.id = id
        self.parameter = parameter
        self.value = value
    }
    
    
}
