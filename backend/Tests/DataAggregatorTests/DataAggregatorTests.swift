@testable import DataAggregator
import VaporTesting
import Testing
import Fluent

@Suite("App Tests with DB", .serialized)
struct DataAggregatorTests {
    private func withApp(_ test: (Application) async throws -> ()) async throws {
        let app = try await Application.make(.testing)
        do {
            try await configure(app)
            try await app.autoMigrate()
            try await test(app)
            try await app.autoRevert()
        } catch {
            try? await app.autoRevert()
            try await app.asyncShutdown()
            throw error
        }
        try await app.asyncShutdown()
    }
    
    @Test("I'm a success")
    func success() async {
        #expect(true)
    }
    
}
