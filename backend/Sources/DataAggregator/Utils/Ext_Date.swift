import Vapor

extension Date {
    static func intervalFromNow(_ time: TimeInterval.Time) -> Date {
        return Date().addingTimeInterval(time.interval)
    }
}
