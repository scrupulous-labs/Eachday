import SwiftUI

struct AppViewHabitCardContextMenu: View {
    let habit: HabitModel
    let editHabit: () -> ()
    let editHabitHistory: () -> ()
     
    var body: some View {
        Button { editHabit() } label: {
            Label("Edit", systemImage: "pencil")
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
