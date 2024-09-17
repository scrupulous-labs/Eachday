import SwiftUI

struct HabitDetailsStreaks: View {
    var habit: HabitModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Text("Current streak")
                    .font(Font.headline.weight(.light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                Text("0")
                    .font(Font.system(size: 42).weight(.bold))
                    .foregroundColor(habit.color.shade5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
            .cornerRadius(10)
            
            VStack {
                Text("Longest streak")
                    .font(Font.headline.weight(.light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                Text("0")
                    .font(Font.system(size: 42).weight(.bold))
                    .foregroundColor(habit.color.shade5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
            .cornerRadius(10)
        }
    }
}
