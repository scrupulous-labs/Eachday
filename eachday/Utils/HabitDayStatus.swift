import Foundation

enum HabitDayStatus: Hashable, Comparable {
    case completed
    case partiallyCompleted(value: Double)
    case notCompleted
    
    var percentage: Double {
        switch self {
        case .completed: 1.0
        case .partiallyCompleted(let percentage): percentage
        case .notCompleted: 0.0
        }
    }
    
    static func < (lhs: HabitDayStatus, rhs: HabitDayStatus) -> Bool {
        switch (lhs, rhs) {
        case (.completed, .completed):
            return false
        case (.completed, .partiallyCompleted(_)):
            return false
        case (.completed, .notCompleted):
            return false
        case (.partiallyCompleted(_), .completed):
            return false
        case (.partiallyCompleted(let p1), .partiallyCompleted(let p2)):
            return p1 < p2
        case (.partiallyCompleted(_), .notCompleted):
            return true
        case (.notCompleted, .completed):
            return true
        case (.notCompleted, .partiallyCompleted(_)):
            return true
        case (.notCompleted, .notCompleted):
            return false
        }
    }
    
    static func == (lhs: HabitDayStatus, rhs: HabitDayStatus) -> Bool {
        switch (lhs, rhs) {
        case (.completed, .completed):
            return true
        case (.partiallyCompleted(let p1), .partiallyCompleted(let p2)):
            return p1 == p2
        case (.notCompleted, .notCompleted):
            return true
        default:
            return false
        }
    }
    
    static func fromPercentage(_ percentage: Double) -> HabitDayStatus {
        if percentage >= 1 {
            return .completed
        } else if percentage > 0 {
            return .partiallyCompleted(value: percentage)
        } else {
            return .notCompleted
        }
    }
    
    func eitherCompletedOrNot() -> HabitDayStatus {
        switch self {
        case .partiallyCompleted(_):
            return .notCompleted
        default:
            return self
        }
    }
}
