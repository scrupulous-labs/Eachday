import SwiftUI

struct HabitDetailsCard: View {
    var habit: HabitModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 4) {
                VStack(spacing: 4) {
                    Text("TODAY")
                        .font(Font.system(size: 10).weight(.light))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(habit.name)
                        .font(Font.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                MarkHabitButton(habit: habit)
            }
            .padding(.all, 16)
            
            let tasks = habit.habitTasksUI
            let showTasks = !tasks.isEmpty && tasks[0].description.trimmingCharacters(in: .whitespaces) != ""
            let completedTasks = habit.repetitionCompletedTasks(day: Day.today())
            if showTasks {
                VStack(spacing: 10) {
                    ForEach(tasks, id: \.id) { task in
                        let isTaskCompleted = completedTasks.contains { $0.id == task.id }
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: isTaskCompleted ? "checkmark" : "circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .padding(.trailing, 4)
                                .foregroundColor(habit.color.shade5)
                                .fontWeight(.bold)
                            
                            Text(task.description)
                                .font(Font.system(size: 16).weight(.regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                }
                .padding([.leading, .bottom, .trailing], 16)
            }
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
}
