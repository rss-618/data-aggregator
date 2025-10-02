import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
//        let events = EventRepository.default.getAll(req.db)
        return try await req.view.render("index", ["events": [Event(parameter: "test", value: "value")]])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: EventController(repository: .default))
}
