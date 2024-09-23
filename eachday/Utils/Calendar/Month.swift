import Foundation

enum Month: Hashable, Comparable {
    case january(year: Year)
    case february(year: Year)
    case march(year: Year)
    case april(year: Year)
    case may(year: Year)
    case june(year: Year)
    case july(year: Year)
    case august(year: Year)
    case september(year: Year)
    case october(year: Year)
    case november(year: Year)
    case december(year: Year)
    
    var value: Int {
        switch self {
        case .january(_):
            return 1
        case .february(_):
            return 2
        case .march(_):
            return 3
        case .april(_):
            return 4
        case .may(_):
            return 5
        case .june(_):
            return 6
        case .july(_):
            return 7
        case .august(_):
            return 8
        case .september(_):
            return 9
        case .october(_):
            return 10
        case .november(_):
            return 11
        case .december(_):
            return 12
        }
    }
    var year: Year {
        switch self {
        case .january(let year):
            return year
        case .february(let year):
            return year
        case .march(let year):
            return year
        case .april(let year):
            return year
        case .may(let year):
            return year
        case .june(let year):
            return year
        case .july(let year):
            return year
        case .august(let year):
            return year
        case .september(let year):
            return year
        case .october(let year):
            return year
        case .november(let year):
            return year
        case .december(let year):
            return year
        }
    }
    var prev: Month {
        switch self {
        case .january(let year):
            return .december(year: year.prev)
        case .february(let year):
            return .january(year: year)
        case .march(let year):
            return .february(year: year)
        case .april(let year):
            return .march(year: year)
        case .may(let year):
            return .april(year: year)
        case .june(let year):
            return .may(year: year)
        case .july(let year):
            return .june(year: year)
        case .august(let year):
            return .july(year: year)
        case .september(let year):
            return .august(year: year)
        case .october(let year):
            return .september(year: year)
        case .november(let year):
            return .october(year: year)
        case .december(let year):
            return .november(year: year)
        }
    }
    var next: Month {
        switch self {
        case .january(let year):
            return .february(year: year)
        case .february(let year):
            return .march(year: year)
        case .march(let year):
            return .april(year: year)
        case .april(let year):
            return .may(year: year)
        case .may(let year):
            return .june(year: year)
        case .june(let year):
            return .july(year: year)
        case .july(let year):
            return .august(year: year)
        case .august(let year):
            return .september(year: year)
        case .september(let year):
            return .october(year: year)
        case .october(let year):
            return .november(year: year)
        case .november(let year):
            return .december(year: year)
        case .december(let year):
            return .january(year: year.next)
        }
    }
    var shortHand: String {
        switch self {
        case .january(_):
            return "JAN"
        case .february(_):
            return "FEB"
        case .march(_):
            return "MAR"
        case .april(_):
            return "APR"
        case .may(_):
            return "MAY"
        case .june(_):
            return "JUN"
        case .july(_):
            return "JUL"
        case .august(_):
            return "AUG"
        case .september(_):
            return "SEP"
        case .october(_):
            return "OCT"
        case .november(_):
            return "NOV"
        case .december(_):
            return "DEC"
        }
    }
    var startDay: Day {
        return Day(day: 1, month: self)
    }
    var endDay: Day {
        let calendar = Calendar.current
        let startDate = startDay.toDate()
        let numberOfDays = calendar.range(of: .day, in: .month, for: startDate)
        return Day(day: numberOfDays?.count ?? 2, month: self)
    }
    
    static func < (lhs: Month, rhs: Month) -> Bool {
        let (m1, y1) = (lhs.value, lhs.year)
        let (m2, y2) = (rhs.value, rhs.year)
        return y1 != y2 ? y1 < y2 : m1 < m2
    }
    
    static func == (lhs: Month, rhs: Month) -> Bool {
        let (m1, y1) = (lhs.value, lhs.year)
        let (m2, y2) = (rhs.value, rhs.year)
        return m1 == m2 && y1 == y2
    }
    
    static func new(_ month: Int, year: Year) -> Month {
        if (month == 1) { return .january(year: year) }
        else if (month == 2) { return .february(year: year) }
        else if (month == 3) { return .march(year: year) }
        else if (month == 4) { return .april(year: year) }
        else if (month == 5) { return .may(year: year) }
        else if (month == 6) { return .june(year: year) }
        else if (month == 7) { return .july(year: year) }
        else if (month == 8) { return .august(year: year) }
        else if (month == 9) { return .september(year: year) }
        else if (month == 10) { return .october(year: year) }
        else if (month == 11) { return .november(year: year) }
        else { return .december(year: year) }
    }
    
    static func current() -> Month {
        let today = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: today)
        let year = calendar.component(.year, from: today)
        return Month.new(month, year: Year.new(year))
    }
    
    func daysGrid(startOfWeek: WeekDay) -> [Maybe<Day>] {
        let calendar = Calendar.current
        var startDateComponents = DateComponents()
        startDateComponents.day = 1
        startDateComponents.month = value
        startDateComponents.year = year.value
        
        if let startDate = calendar.date(from: startDateComponents) {
            if let range = calendar.range(of: .day, in: .month, for: startDate) {
                var emptyCellCount = calendar.component(.weekday, from: startDate) - startOfWeek.rawValue
                if emptyCellCount < 0 {
                    emptyCellCount += 7
                }
                
                var days: [Maybe<Day>] = Array(repeating: Maybe.nothing, count: emptyCellCount)
                for day in range {
                    days.append(Maybe.just(Day(day: day, month: self)))
                }
                while days.count < 42 {
                    days.append(Maybe.nothing)
                }
                return days
            }
            return []
        }
        return []
    }
}
