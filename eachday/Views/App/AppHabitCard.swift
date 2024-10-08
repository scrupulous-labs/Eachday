import SwiftUI

struct HabitCard: View {
    let habit: HabitModel
    let editHabit: () -> ()
    let editHabitHistory: () -> ()
    
    @Environment(RootStore.self) var rootStore: RootStore
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            AppViewHabitCardHeader(habit: habit)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
            AppViewHabitCardCalendar(habit: habit)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 6, trailing: 12))
        }
        .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#000000"))
        .cornerRadius(10)
        .contextMenu {
            AppViewHabitCardContextMenu(
                habit: habit,
                editHabit: editHabit,
                editHabitHistory: editHabitHistory
            )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    colorScheme == .light ? .black.opacity(0.25) : Color(hex: "#909090"),
                    lineWidth: 0.25
                )
        }
    }
}
