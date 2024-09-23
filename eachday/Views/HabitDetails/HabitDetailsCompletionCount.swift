import SwiftUI

struct HabitDetailsCompletionCount: View {
    var habit: HabitModel
    var completionsByDay: [Day: [TaskCompletionModel]]
    
    var totalCompletions: Int {
        completionsByDay.reduce(0) { res, elem in
            let taskCount = habit.habitTasksUI.count
            let (_, completions) = elem
            return res + (completions.count / taskCount)
        }
    }
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(spacing: 16) {
                Text("Completions")
                    .font(Font.subheadline.weight(.regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                Text(String(totalCompletions))
                    .font(Font.system(size: 42).weight(.bold))
                    .foregroundColor(habit.color.shade5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
//            .frame(maxWidth: .infinity)
            .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
            .cornerRadius(10)
            
//            VStack(spacing: 16) {
//                Text("Completion time ")
//                    .font(Font.subheadline.weight(.light))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 16)
//                    .padding(.top, 10)
//                Text(String(totalCompletions))
//                    .font(Font.system(size: 42).weight(.bold))
//                    .foregroundColor(habit.color.shade5)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                    .padding(.horizontal, 16)
//                    .padding(.bottom, 10)
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
//            .cornerRadius(10)
        }
    }
}
