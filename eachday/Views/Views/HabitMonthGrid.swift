import SwiftUI

struct HabitMonthGrid: View {
    var habit: HabitModel
    var month: Month

    var gridColumnCount = 7
    var gridVerticalSpacing = 1.2
    var gridHorizontalSpacing = 2.4
    var cellSize = 8.0
    var cellCornerRadius = 2.5
    @Environment(\.colorScheme) private var colorScheme
    @Environment(RootStore.self) private var rootStore
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.fixed(cellSize), spacing: gridHorizontalSpacing),
                count: gridColumnCount
            ),
            spacing: gridVerticalSpacing
        ) {
            let startDay = rootStore.settings.value.startOfWeek
            ForEach(Array(month.daysGrid(startOfWeek: startDay).enumerated()), id: \.offset) { (_, maybeDay) in
                switch maybeDay {
                case Maybe.nothing:
                    RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                        .size(width: cellSize, height: cellSize)
                        .opacity(0)

                case Maybe.just(let day):
                    RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                        .size(width: cellSize, height: cellSize)
                        .fill(Color(hex: colorScheme == .light ? "#f3f4f6" : "#1e293b"))
                        .overlay {
                            RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                                .size(width: cellSize, height: cellSize)
                                .fill(habit.color.shadeLight.opacity(colorScheme == .light ? 0.8 : 0.6))
                                .overlay {
                                    RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                                        .size(width: cellSize, height: cellSize)
                                        .fill(habit.color.calendarShade(
                                            percentage: habit.dayStatus(day: day).percentage
                                        ))
                                }
                            
                            if day == Day.today() {
                                RoundedRectangle(cornerRadius: cellCornerRadius + 1, style: .continuous)
                                    .size(width: cellSize + 2.35, height: cellSize + 2.35)
                                    .stroke(colorScheme == .light ? .black : .white, lineWidth: 1.25)
                                    .offset(x: -1.18, y: -1.17)
                            }
                        }
                }
            }
        }
    }
}
