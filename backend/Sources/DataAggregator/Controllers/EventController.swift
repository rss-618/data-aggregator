import Fluent
import Vapor
import Dependencies

struct EventController: RouteCollection {
    
    @Dependency(\.service) var service
    
    func boot(routes: any RoutesBuilder) throws {
        let events = routes.grouped("event")
        
        events.get("all") { req in
            return try await service.event.getAllDisplayEvents(on: req.db)
        }
        
        events.post { req in
            try await service.event.addEvent(
                event: req.content.decode(AddEventRequest.self),
                on: req.db
            )
            return HTTPStatus.ok
        }
        
        events.put { req in
            try await service.event.updateEvent(
                request: req.content.decode(UpdateEventRequest.self),
                on: req.db
            )
            return HTTPStatus.ok
        }
        
        events.delete("", ":id") { req in
            guard let uuidString = req.parameters.get("id"),
                  let id = UUID(uuidString: uuidString) else {
                throw Abort(.badRequest)
            }
            try await service.event.deleteEvent(id: id, on: req.db)
            return HTTPStatus.ok
        }
    }
    
}
