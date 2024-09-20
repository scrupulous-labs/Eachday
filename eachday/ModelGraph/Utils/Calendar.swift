import Foundation
import HorizonCalendar

struct Day: Hashable, Comparable {
    let day: Int
    let month: Month
    
    static func < (lhs: Day, rhs: Day) -> Bool {
        return lhs.month != rhs.month ? lhs.month < rhs.month : lhs.day < rhs.day
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.day == rhs.day && lhs.month == rhs.month
    }
    
    static func today() -> Day {
        return Day.fromDate(Date())
    }
    
    static func yesterday() -> Day {
        let currentDate = Date()
        let calendar = Calendar.current
        if let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: currentDate) {
            return Day.fromDate(yesterdayDate)
        } else {
            return today() // some day
        }
    }

    static func fromDate(_ date: Date) -> Day {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return Day(day: day, month: Month.fromIndex(month, year: year))
    }
    
    static func fromDayComponents(_ dayComponents: DayComponents) -> Day {
        return Day(
            day: dayComponents.day,
            month: Month.fromIndex(
                dayComponents.month.month,
                year: dayComponents.month.year
            )
        )
    }
    
    func toDate() -> Date {
        let calendar = Calendar.current
        let (monthInd, year) = month.toIndex()
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = monthInd
        dateComponents.year = year
        return calendar.date(from: dateComponents)!
    }
}

enum DayOfWeek: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
}

enum Month: Hashable, Comparable {
    case january(year: Int)
    case february(year: Int)
    case march(year: Int)
    case april(year: Int)
    case may(year: Int)
    case june(year: Int)
    case july(year: Int)
    case august(year: Int)
    case september(year: Int)
    case october(year: Int)
    case november(year: Int)
    case december(year: Int)
    
    static func < (lhs: Month, rhs: Month) -> Bool {
        let (m1, year: y1) = lhs.toIndex()
        let (m2, year: y2) = rhs.toIndex()
        return y1 != y2 ? y1 < y2 : m1 < m2
    }
    
    static func == (lhs: Month, rhs: Month) -> Bool {
        let (m1, year: y1) = lhs.toIndex()
        let (m2, year: y2) = rhs.toIndex()
        return m1 == m2 && y1 == y2
    }
    
    static func current() -> Month {
        let today = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: today)
        let year = calendar.component(.year, from: today)
        return Month.fromIndex(month, year: year)
    }
    
    static func fromIndex(_ index: Int, year: Int) -> Month {
        if (index == 1) { return .january(year: year) }
        else if (index == 2) { return .february(year: year) }
        else if (index == 3) { return .march(year: year) }
        else if (index == 4) { return .april(year: year) }
        else if (index == 5) { return .may(year: year) }
        else if (index == 6) { return .june(year: year) }
        else if (index == 7) { return .july(year: year) }
        else if (index == 8) { return .august(year: year) }
        else if (index == 9) { return .september(year: year) }
        else if (index == 10) { return .october(year: year) }
        else if (index == 11) { return .november(year: year) }
        else { return .december(year: year) }
    }
    
    func toIndex() -> (Int, year: Int) {
        switch self {
        case .january(let year):
            return (1, year)
        case .february(let year):
            return (2, year)
        case .march(let year):
            return (3, year)
        case .april(let year):
            return (4, year)
        case .may(let year):
            return (5, year)
        case .june(let year):
            return (6, year)
        case .july(let year):
            return (7, year)
        case .august(let year):
            return (8, year)
        case .september(let year):
            return (9, year)
        case .october(let year):
            return (10, year)
        case .november(let year):
            return (11, year)
        case .december(let year):
            return (12, year)
        }
    }
    
    func prev() -> Month {
        switch self {
        case .january(let year):
            return .december(year: year - 1)
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
    
    func next() -> Month {
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
            return .january(year: year + 1)
        }
    }
    
    func year() -> Int {
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
    
    func shortHand() -> String {
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
    
    func startDay() -> Day {
        return Day(day: 1, month: self)
    }
    
    func endDay() -> Day {
        let calendar = Calendar.current
        let startDate = startDay().toDate()
        let numberOfDays = calendar.range(of: .day, in: .month, for: startDate)
        return Day(day: numberOfDays?.count ?? 2, month: self)
    }
    
    func daysGrid(startDay: DayOfWeek) -> [Maybe<Day>] {
        let calendar = Calendar.current
        let (monthInd, year) = toIndex()
        
        var startDateComponents = DateComponents()
        startDateComponents.day = 1
        startDateComponents.month = monthInd
        startDateComponents.year = year
        
        if let startDate = calendar.date(from: startDateComponents) {
            if let range = calendar.range(of: .day, in: .month, for: startDate) {
                var emptyCellCount = calendar.component(.weekday, from: startDate) - startDay.rawValue
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
