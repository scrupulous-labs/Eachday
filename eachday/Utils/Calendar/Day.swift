import Foundation
import HorizonCalendar

struct Day: Hashable, Comparable {
    let day: Int
    let month: Month

    var week: Week {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.weekOfYear], from: toDate())
        return Week.new(dateComponents.weekOfYear ?? 1, year: month.year)
    }
    var prev: Day {
        let calendar = Calendar.current
        if let prevDay = calendar.date(byAdding: .day, value: -1, to: toDate()) {
            return Day.fromDate(prevDay)
        } else {
            return self
        }
    }
    var next: Day {
        let calendar = Calendar.current
        if let nextDay = calendar.date(byAdding: .day, value: 1, to: toDate()) {
            return Day.fromDate(nextDay)
        } else {
            return self
        }
    }
    
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
    
    static func tomorrow() -> Day {
        let currentDate = Date()
        let calendar = Calendar.current
        if let tomorrowDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            return Day.fromDate(tomorrowDate)
        } else {
            return today() // some day
        }
    }

    static func fromDate(_ date: Date) -> Day {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return Day(
            day: day,
            month: Month.new(month, year: Year.new(year))
        )
    }
    
    static func fromDayComponents(_ dayComponents: DayComponents) -> Day {
        return Day(
            day: dayComponents.day,
            month: Month.new(
                dayComponents.month.month,
                year: Year.new(dayComponents.month.year)
            )
        )
    }
    
    func toDate() -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month.value
        dateComponents.year = month.year.value
        return calendar.date(from: dateComponents) ?? Date()
    }
}
