import SwiftUI

struct HabitDetailsCalendar: View {
    var year: Year
    var habit: HabitModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                ForEach([
                    Month.january(year: year),
                    Month.february(year: year),
                    Month.march(year: year),
                    Month.april(year: year)
                ], id: \.self) { month in
                    VStack {
                        Text(month.shortHand)
                            .font(Font.system(size: 10).weight(.light))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, -2)
                        HabitMonthGrid(habit: habit, month: month)
                    }
                }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            
            HStack {
                ForEach([
                    Month.may(year: year),
                    Month.june(year: year),
                    Month.july(year: year),
                    Month.august(year: year)
                ], id: \.self) { month in
                    VStack {
                        Text(month.shortHand)
                            .font(Font.system(size: 10).weight(.light))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 0)
                        HabitMonthGrid(habit: habit, month: month)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
            HStack {
                ForEach([
                    Month.september(year: year),
                    Month.october(year: year),
                    Month.november(year: year),
                    Month.december(year: year)
                ], id: \.self) { month in
                    VStack {
                        Text(month.shortHand)
                            .font(Font.system(size: 10).weight(.light))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, -2)
                        HabitMonthGrid(habit: habit, month: month)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 7, trailing: 16))
        }
        .background(colorScheme == .light
            ? AnyShapeStyle(Color(hex: "#FFFFFF"))
            : AnyShapeStyle(.ultraThinMaterial.opacity(0.6))
        )
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    colorScheme == .light ? .black.opacity(0.25) : .white.opacity(0.2),
                    lineWidth: 0.25
                )
        }
    }
}
