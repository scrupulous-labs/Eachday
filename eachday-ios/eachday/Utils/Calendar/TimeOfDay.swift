import Foundation

struct TimeOfDay: Hashable, Comparable {
    let value: Int
    var hour: Int { value / 60 }
    var minute: Int { value % 60 }
    
    static func < (lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func == (lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func fromDate(_ date: Date) -> TimeOfDay {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        if let hour = dateComponents.hour, let minute = dateComponents.minute {
            return TimeOfDay(value: hour * 60 + minute)
        } else {
            return TimeOfDay(value: 12 * 60)
        }
    }
    
    func toDate() -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = 1
        dateComponents.year = 2024
        dateComponents.hour = hour
        dateComponents.minute = minute
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }
}
