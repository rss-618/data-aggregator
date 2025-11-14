import Foundation

extension TimeInterval {
    enum Time: Equatable {
        internal static let minute: TimeInterval = 60
        internal static let hour: TimeInterval = Self.minute * 60
        internal static let day: TimeInterval = Self.hour * 24
        case minutes(Double)
        case hour(Double)
        case days(Double)
        
        var interval: TimeInterval {
            switch self {
            case .minutes(let minutes):
                Self.minute * minutes
            case .hour(let hours):
                Self.hour * hours
            case .days(let days):
                Self.day * days
            }
        }
    }
}
