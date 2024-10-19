import SwiftUI

struct AppViewHabitCardContextMenu: View {
    let habit: HabitModel
    let editHabit: () -> ()
    let editHabitHistory: () -> ()
    let reorderHabits: () -> ()
     
    var body: some View {
        Button { editHabit() } label: {
            Label("Edit", systemImage: "pencil")
        }
        Button { reorderHabits() } label: {
            Label("Reorder Habits", systemImage: "arrow.up.arrow.down")
        }
        Button { editHabitHistory() } label: {
            Label("Mark Previous Days", systemImage: "clock.arrow.circlepath")
        }
        Divider()
        Button { habit.archive() } label: {
            Label("Archive", systemImage: "archivebox")
        }
    }
}
