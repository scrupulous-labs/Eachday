import Foundation
import Charts

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
        case .january(_): 1
        case .february(_): 2
        case .march(_): 3
        case .april(_): 4
        case .may(_): 5
        case .june(_): 6
        case .july(_): 7
        case .august(_): 8
        case .september(_): 9
        case .october(_): 10
        case .november(_): 11
        case .december(_): 12
        }
    }
    var year: Year {
        switch self {
        case .january(let year): year
        case .february(let year): year
        case .march(let year): year
        case .april(let year): year
        case .may(let year): year
        case .june(let year): year
        case .july(let year): year
        case .august(let year): year
        case .september(let year): year
        case .october(let year): year
        case .november(let year): year
        case .december(let year): year
        }
    }
    var prev: Month {
        switch self {
        case .january(let year): .december(year: year.prev)
        case .february(let year): .january(year: year)
        case .march(let year): .february(year: year)
        case .april(let year): .march(year: year)
        case .may(let year): .april(year: year)
        case .june(let year): .may(year: year)
        case .july(let year): .june(year: year)
        case .august(let year): .july(year: year)
        case .september(let year): .august(year: year)
        case .october(let year): .september(year: year)
        case .november(let year): .october(year: year)
        case .december(let year): .november(year: year)
        }
    }
    var next: Month {
        switch self {
        case .january(let year): .february(year: year)
        case .february(let year): .march(year: year)
        case .march(let year): .april(year: year)
        case .april(let year): .may(year: year)
        case .may(let year): .june(year: year)
        case .june(let year): .july(year: year)
        case .july(let year): .august(year: year)
        case .august(let year): .september(year: year)
        case .september(let year): .october(year: year)
        case .october(let year): .november(year: year)
        case .november(let year): .december(year: year)
        case .december(let year): .january(year: year.next)
        }
    }
    var symbol: String {
        switch self {
        case .january(_): "J"
        case .february(_): "F"
        case .march(_): "M"
        case .april(_): "A"
        case .may(_): "M    "
        case .june(_): "J "
        case .july(_): "J "
        case .august(_): "Aᅟᅟ឴"
        case .september(_): "S"
        case .october(_): "O"
        case .november(_): "N"
        case .december(_): "D"
        }
    }
    var shortHand: String {
        switch self {
        case .january(_): "JAN"
        case .february(_): "FEB"
        case .march(_): "MAR"
        case .april(_): "APR"
        case .may(_): "MAY"
        case .june(_): "JUN"
        case .july(_): "JUL"
        case .august(_): "AUG"
        case .september(_): "SEP"
        case .october(_): "OCT"
        case .november(_): "NOV"
        case .december(_): "DEC"
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
