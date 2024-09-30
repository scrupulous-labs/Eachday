import SwiftUI

struct HabitCard: View {
    let habit: HabitModel
    let editHabit: () -> ()
    let editHabitHistory: () -> ()
    
    @Environment(ModelGraph.self) var modelGraph: ModelGraph
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            AppViewHabitCardHeader(habit: habit)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
            AppViewHabitCardCalendar(habit: habit)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 6, trailing: 12))
        }
        .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
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
                .stroke(.black.opacity(0.25), lineWidth: 0.25)
        }
    }
}
