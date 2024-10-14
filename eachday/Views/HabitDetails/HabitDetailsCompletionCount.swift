import SwiftUI
import Charts

struct HabitDetailsCompletionCount: View {
    var year: Year
    var habit: HabitModel
    var completionsByDay: [Day: [TaskCompletionModel]]
    
    var completionCountString: AttributedString {
        var text = AttributedString("\(completionCount) times")
        text.font = .subheadline.weight(.bold)
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
        VStack(spacing: 12) {
            Text("Completed a total of \(completionCountString)")
                .font(Font.subheadline.weight(.regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
            
            VStack(spacing: 14) {
                Text("Times completed per month")
                    .font(Font.caption.weight(.light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Chart(year.allMonths, id: \.self) { month in
                    BarMark(
                        x: .value("Month", month.symbol),
                        y: .value("Completion count", compeletionCountPerMonth(month))
                    )
                }
                .foregroundColor(habit.color.shade5)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#000000"))
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    colorScheme == .light ? .black.opacity(0.25) : Color(hex: "#909090"),
                    lineWidth: 0.25
                )
        }
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
