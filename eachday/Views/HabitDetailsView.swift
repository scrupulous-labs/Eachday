import SwiftUI

struct HabitDetailsView: View {
    var habit: HabitModel

    @Bindable var ui: HabitDetailsViewModel = HabitDetailsViewModel.instance
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            let completionsByDay = completionsForYear(year: ui.year)
            VStack(spacing: 0) {
                HabitDetailsCard(
                    habit: habit
                )
                .padding(.bottom, 30)
                
                HabitDetailsCalendar(
                    habit: habit,
                    year: ui.year,
                    onYearChange: ui.setYear
                )
                .padding(.bottom, 16)
                
                HabitDetailsStreaks(
                    habit: habit,
                    completionsByDay: completionsByDay,
                    completionsByDayAll: habit.completionsByDay
                )
                .padding(.bottom, 12)
                
                HabitDetailsCompletionCount(
                    habit: habit,
                    completionsByDay: completionsByDay
                )
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
    
    func completionsForYear(year: Year) -> [Day: [TaskCompletionModel]] {
        return habit.completionsByDay.filter { (day, _) in
            day.month.year == year
        }
    }
}

@Observable
class HabitDetailsViewModel {
    static let instance: HabitDetailsViewModel = HabitDetailsViewModel()
    
    var year: Year = Day.today().month.year
    var activeSheet: HabitDetailsSheet? = nil
    var userAttemptedToDismissSheet: Bool = false
    var canInteractivelyDismissSheet: Bool = true

    func setYear(year: Year) {
        self.year = year
    }
}
