import SwiftUI

struct RemindersMinimap: View {
    var habit: HabitModel
    
    var daysOfWeek: [DayOfWeek] {
        DayOfWeek.allDaysOfWeek(
            startOfWeek: modelGraph.settingsUI.startOfWeek
        )
    }
    var activeDaysOfWeek: Set<DayOfWeek> {
        let reminders = habit.habitRemindersUI
        var result: Set<DayOfWeek> = Set()
        if reminders.contains(where: { $0.sunday }) {
            result.insert(.sunday)
        }
        if reminders.contains(where: { $0.monday }) {
            result.insert(.monday)
        }
        if reminders.contains(where: { $0.tuesday }) {
            result.insert(.tuesday)
        }
        if reminders.contains(where: { $0.wednesday }) {
            result.insert(.wednesday)
        }
        if reminders.contains(where: { $0.thursday }) {
            result.insert(.thursday)
        }
        if reminders.contains(where: { $0.friday }) {
            result.insert(.friday)
        }
        if reminders.contains(where: { $0.saturday }) {
            result.insert(.saturday)
        }
        return result
    }
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(daysOfWeek, id: \.self) { day in
                let isActive = activeDaysOfWeek.contains(day)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .light ? .black : .white, lineWidth: 0.5)
                    .fill(isActive ? .green : .white.opacity(0))
                    .frame(width: 12, height: 12)
            }
        }
    }
}
