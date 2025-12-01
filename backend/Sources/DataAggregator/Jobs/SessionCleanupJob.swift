import Foundation
import Queues
import Fluent

struct SessionCleanupJob: AsyncScheduledJob {
    func run(context: Queues.QueueContext) async throws {
        let db = context.application.db
        let expired = try await db
            .query(SessionRecord.self)
            .all()
            .filter { $0.data.isExpired }
        for row in expired {
            try await row.delete(on: db)
        }
    }
}
