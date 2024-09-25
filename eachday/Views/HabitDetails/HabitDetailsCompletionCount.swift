import SwiftUI
import Charts

struct HabitDetailsCompletionCount: View {
    var year: Year
    var habit: HabitModel
    var completionsByDay: [Day: [TaskCompletionModel]]
    
    var completionCountString: AttributedString {
        var text = AttributedString("\(completionCount) times")
        text.font = .subheadline.weight(.bold)
        text.underlineStyle = .single
        text.foregroundColor = habit.color.shade5
        return text
    }
    var completionCount: Int {
        completionsByDay.reduce(0) { res, elem in
            let taskCount = habit.habitTasksUI.count
            let (_, completions) = elem
            return res + (completions.count / taskCount)
        }
    }
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Completed a total of \(completionCountString)")
                .font(Font.subheadline.weight(.regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
            
            VStack(spacing: 16) {
                Text("Times completed per month")
                    .font(Font.caption.weight(.light))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Chart(year.allMonths, id: \.self) { month in
                    BarMark(
                        x: .value("Month", month.symbol),
                        y: .value("Completion count", compeletionCountPerMonth(month))
                    )
                }
                .foregroundColor(habit.color.shade5)
            }
            .padding(.all, 16)
        }
        .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
        .cornerRadius(10)
    }
    
    func compeletionCountPerMonth(_ month: Month) -> Int {
        completionsByDay
            .filter { $0.key.month == month }
            .reduce(0) { res, elem in
                let taskCount = habit.habitTasksUI.count
                let (_, completions) = elem
                return res + (completions.count / taskCount)
            }
    }
}
