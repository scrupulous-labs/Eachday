import SwiftUI
import HorizonCalendar

struct EditHabitHistory: View {
    let habit: HabitModel
    @Binding var canCancel: Bool
    @Binding var attemptedToCancel: Bool
    
    @State private var calendarViewProxy = CalendarViewProxy()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Environment(RootStore.self) private var rootStore
    
    let cellPadding = 5.0
    let cellCornerRadius = 5.0
    let endDate: Date = Day.today().toDate()
    let startDate: Date = Month.current()
        .prev.prev.prev.prev.prev.prev
        .prev.prev.prev.prev.prev.prev
        .startDay.toDate()
    var customCalendar: Calendar {
        var cal = Calendar.current
        cal.firstWeekday = rootStore.settings.value.startOfWeek.rawValue
        return cal
    }
    
    var body: some View {
        VStack {
            HStack {
                Button { cancel() } label: { Text("Cancel").fontWeight(.medium) }
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button { done() } label: { Text("Done").fontWeight(.medium) }
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
            
            CalendarViewRepresentable(
                calendar: customCalendar,
                visibleDateRange: startDate...endDate,
                monthsLayout: .vertical(
                    options: VerticalMonthsLayoutOptions(
                        alwaysShowCompleteBoundaryMonths: false
                    )
                ),
                dataDependency: habit.completionsByDay,
                proxy: calendarViewProxy
            )
            .days { dayComponents in
                let day = Day.fromDayComponents(dayComponents)
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: cellCornerRadius)
                        .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
                        .padding(cellPadding)
                        .overlay {
                            RoundedRectangle(cornerRadius: cellCornerRadius)
                                .fill(habit.color.shadeLight)
                                .padding(cellPadding)
                                .overlay {
                                    RoundedRectangle(cornerRadius: cellCornerRadius)
                                        .fill(habit.color.calendarShade(
                                            percentage: habit.dayStatus(day: day).percentage
                                        ))
                                        .padding(cellPadding)
                                }
                        }
                    
                    let repetitionsPerDay = habit.frequency.repetitionsPerDay
                    let repetitionsCompleted = habit.repetitionsCompleted(day: day)
                    VStack(spacing: 0) {
                        Text("\(day.day)")
                            .font(Font.headline.weight(.medium))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(repetitionsCompleted > 0
                                ? (colorScheme == .light ? .white : .white)
                                : (colorScheme == .light ? .black : .white)
                            )
                        if repetitionsPerDay > 1 && repetitionsCompleted > 0 {
                            Text("x\(min(repetitionsPerDay, repetitionsCompleted))")
                                .font(Font.system(size: 14).weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.white)
                                .offset(y: -2)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    if day == Day.today() {
                        RoundedRectangle(cornerRadius: cellCornerRadius + 2)
                            .stroke(colorScheme == .light ? .black : .white, lineWidth: 2)
                            .padding(cellPadding - 3)
                    }
                }
                .onTapGesture {
                    habit.isCompleted(day: day)
                        ? habit.unmarkDay(day: day)
                        : habit.markNextRepetition(day: day)
                    canCancel = !habit.isGraphModified
                }
            }
            .interMonthSpacing(38)
            .padding([.horizontal])
        }
        .confirmationDialog(
            "Are you sure you want to discard this new habit?",
            isPresented: $attemptedToCancel,
            titleVisibility: .visible
        ) {
            Button("Discard Changes", role: .destructive) { discardChanges() }
            Button("Keep Editing", role: .cancel) { }
        }
        .onAppear {
            calendarViewProxy.scrollToDay(
                containing: endDate,
                scrollPosition: .lastFullyVisiblePosition,
                animated: false
            )
        }
    }
    
    func done() { habit.save(); dismiss() }
    func cancel() { if canCancel { discardChanges() } else { attemptedToCancel = true } }
    func discardChanges() { habit.graphResetToDb(); dismiss() }
}
