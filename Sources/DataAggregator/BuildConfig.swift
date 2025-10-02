import Foundation

open class BuildConfig {
    
    // Should never be mutated (if mutated change this class to an actor)
    nonisolated(unsafe) static let shared: BuildConfig = .init()
    
    var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}
