import Foundation

struct Week: Hashable, Comparable {
    let week: Int
    let year: Year
    
    var prev: Week {
        Week.new(week - 1, year: year)
    }
    var next: Week {
        Week.new(week + 1, year: year)
    }
    
    static func < (lhs: Week, rhs: Week) -> Bool {
        let (w1, y1) = (lhs.week, lhs.year)
        let (w2, y2) = (rhs.week, rhs.year)
        return y1 != y2 ? y1 < y2 : w1 < w2
    }
    
    static func == (lhs: Week, rhs: Week) -> Bool {
        let (w1, y1) = (lhs.week, lhs.year)
        let (w2, y2) = (rhs.week, rhs.year)
        return w1 == w2 && y1 == y2
    }
    
    static func new(_ week: Int, year: Year) -> Week {
        return Week(week: week, year: year)
    }
}
