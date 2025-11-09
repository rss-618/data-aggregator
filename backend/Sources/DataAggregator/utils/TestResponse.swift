import Foundation

enum TestResponse<T: Sendable>: Sendable {
    case success(T)
    case failure(any Error)
    
    func result() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
