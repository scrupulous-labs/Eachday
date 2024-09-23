import SwiftUI

struct AppViewHabitCardCalendar: View {
    var habit: HabitModel
    var currentMonth = Month.current()
    
    var body: some View {
        HStack {
            ForEach([
                currentMonth.prev.prev.prev,
                currentMonth.prev.prev,
                currentMonth.prev,
                currentMonth
            ], id: \.self) { month in
                HabitMonthGrid(habit: habit, month: month)
            }
        }
    }
}
