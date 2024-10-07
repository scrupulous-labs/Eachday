import SwiftUI

struct HabitMonthGrid: View {
    var habit: HabitModel
    var month: Month

    var gridItemWidth = 10.0
    var gridColumnCount = 7
    var gridVerticalSpacing = 1.0
    var gridHorizontalSpacing = 1.2
    var cellSize = 8.0
    var cellCornerRadius = 2.0
    @Environment(\.colorScheme) private var colorScheme
    @Environment(RootStore.self) private var rootStore
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.fixed(gridItemWidth), spacing: gridHorizontalSpacing),
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
                        .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
                        .overlay {
                            RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                                .size(width: cellSize, height: cellSize)
                                .fill(habit.color.shade1)
                                .overlay {
                                    RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                                        .size(width: cellSize, height: cellSize)
                                        .fill(habit.dayCalendarColor(day: day))
                                }
                            
                            if day == Day.today() {
                                RoundedRectangle(cornerRadius: cellCornerRadius + 1, style: .continuous)
                                    .size(width: cellSize + 2, height: cellSize + 2)
                                    .stroke(colorScheme == .light ? .black : .white, lineWidth: 1)
                                    .offset(x: -1, y: -1)
                            }
                        }
                }
            }
        }
    }
}
