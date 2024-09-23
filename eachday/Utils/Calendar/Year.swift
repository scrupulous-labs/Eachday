import Foundation

struct Year: Hashable, Comparable {
    let value: Int
    
    var prev: Year {
        Year.new(value - 1)
    }
    var next: Year {
        Year.new(value + 1)
    }
    var totalWeeks: Int {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = value
        components.month = 1
        components.day = 1
        guard let startDate = calendar.date(from: components) else {
            return 0
        }
        components.month = 12
        components.day = 31
        guard let endDate = calendar.date(from: components) else {
            return 0
        }
        let weeks = calendar.dateComponents([.weekOfYear], from: startDate, to: endDate)
        return weeks.weekOfYear ?? 0
    }
    
    static func < (lhs: Year, rhs: Year) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func == (lhs: Year, rhs: Year) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func new(_ year: Int) -> Year {
        return Year(value: year)
    }
    
    static func current() -> Year {
        let today = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: today)
        return Year.new(year)
    }
}
