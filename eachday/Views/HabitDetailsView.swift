import SwiftUI

struct HabitDetailsView: View {
    var habit: HabitModel
    @Bindable var ui: HabitDetailsViewModel = HabitDetailsViewModel.instance
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HabitDetailsCard(habit: habit).padding(.bottom, 14)
                HabitDetailsCalendar(habit: habit, year: ui.year, onYearChange: ui.setYear)
                HabitDetailsStreaks(habit: habit)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .background(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button { ui.activeSheet = HabitDetailsSheet.editHabitSheet } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button { ui.activeSheet = HabitDetailsSheet.editHabitHistorySheet } label: {
                        Label("Mark Previous Days", systemImage: "clock.arrow.circlepath")
                    }
                    Button { } label: {
                        Label("Delete", systemImage: "trash").background(.red)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .fullScreenCover(item: $ui.activeSheet) { item in
            switch item {
            case HabitDetailsSheet.editHabitSheet:
                EditHabitView(
                    habit: habit,
                    canCancel: $ui.canInteractivelyDismissSheet,
                    attemptedToCancel: $ui.userAttemptedToDismissSheet
                )
            case HabitDetailsSheet.editHabitHistorySheet:
                EditHabitHistory(
                    habit: habit,
                    canCancel: $ui.canInteractivelyDismissSheet,
                    attemptedToCancel: $ui.userAttemptedToDismissSheet
                )
            }
        }
    }
}

@Observable
class HabitDetailsViewModel {
    static let instance: HabitDetailsViewModel = HabitDetailsViewModel()
    
    var year: Int = Day.today().month.year()
    var activeSheet: HabitDetailsSheet? = nil
    var userAttemptedToDismissSheet: Bool = false
    var canInteractivelyDismissSheet: Bool = true

    func setYear(year: Int) {
        self.year = year
    }
}
