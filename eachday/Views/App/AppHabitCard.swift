import SwiftUI

struct HabitCard: View {
    let habit: HabitModel
    let locked: Bool
    let editHabit: () -> Void
    let editHabitHistory: () -> Void
    let reorderHabits: () -> Void
    let openPurchasePro: () -> Void
    
    @Environment(RootStore.self) var rootStore: RootStore
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                AppViewHabitCardHeader(habit: habit)
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
                AppViewHabitCardCalendar(habit: habit)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 6, trailing: 12))
            }
            .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#000000"))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        colorScheme == .light ? .black.opacity(0.25) : Color(hex: "#909090"),
                        lineWidth: 0.25
                    )
            }
            
            if locked {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThickMaterial)
                    .opacity(0.8)
                
                VStack(spacing: 16) {
                    Button { openPurchasePro() } label: { Text("Get Eachday Pro") }
                        .buttonStyle(.borderedProminent)
                    Text("Get Eachday Pro to manage more than 4 habits")
                        .font(Font.system(size: 14))
                }
            }
        }
        .cornerRadius(10)
        .contextMenu {
            if !locked {
                AppViewHabitCardContextMenu(
                    habit: habit,
                    editHabit: editHabit,
                    editHabitHistory: editHabitHistory,
                    reorderHabits: reorderHabits
                )
            }
        }
    }
}
