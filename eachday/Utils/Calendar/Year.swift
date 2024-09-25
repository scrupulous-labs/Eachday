import Foundation

struct Year: Hashable, Comparable {
    let value: Int
    
    var prev: Year {
        Year.new(value - 1)
    }
    var next: Year {
        Year.new(value + 1)
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
