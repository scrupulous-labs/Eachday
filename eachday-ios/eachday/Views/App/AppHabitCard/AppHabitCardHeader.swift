import SwiftUI

struct AppViewHabitCardHeader: View {
    let habit: HabitModel
    
    let headerHeight = 44.0
    let habitIconSize = 22.0
    let habitIconBgSize = 42.0
    let habitIconBgCornerRadius = 8.0
    let today = Day.today()
    @Environment(\.colorScheme) private var colorScheme
    
    var iconForegroundColor: Color { colorScheme == .light
        ? Color.black
        : Color.white
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: habitIconBgCornerRadius, style: .continuous)
                    .size(width: habitIconBgSize, height: habitIconBgSize)
                    .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#1f2937"))
                    .overlay {
                        RoundedRectangle(cornerRadius: habitIconBgCornerRadius, style: .continuous)
                            .size(width: habitIconBgSize, height: habitIconBgSize)
                            .fill(habit.color.shadeLight)
                    }
                Image(systemName: colorScheme == .light ? habit.icon.symbol : habit.icon.symbolDark)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: habitIconSize, height: habitIconSize)
                    .foregroundColor(iconForegroundColor)
                    .fontWeight(.light)
            }
            .frame(width: habitIconBgSize, height: habitIconBgSize)
            
            VStack(spacing: 4) {
                Text("\(habit.name)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 17))
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                let nextTask = habit.nextTaskToComplete(day: today)
                if habit.isCompleted(day: today) {
                    Text("✓ Done for today")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.system(size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(.green)
                } else if nextTask != nil && nextTask!.description.trimmingCharacters(in: .whitespaces) != "" {
                    Text("\(nextTask!.description)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.system(size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            
            MarkHabitButton(habit: habit)
        }
        .frame(height: headerHeight)
    }
}
