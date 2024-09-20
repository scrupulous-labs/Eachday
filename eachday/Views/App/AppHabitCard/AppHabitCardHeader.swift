import SwiftUI

struct AppViewHabitCardHeader: View {
    let habit: HabitModel
    
    let headerHeight = 44.0
    let headerIconHeight = 38.0
    let iconCornerRadius = 6.0
    let today = Day.today()
    @Environment(\.colorScheme) private var colorScheme
    
    var iconForegroundColor: Color { colorScheme == .light
        ? Color.black
        : Color.white
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                    .size(width: headerIconHeight, height: headerIconHeight)
                    .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
                    .overlay {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: headerIconHeight, height: headerIconHeight)
                            .fill(habit.color.shade1)
                    }
                Image(systemName: habit.icon.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .foregroundColor(iconForegroundColor)
                    .fontWeight(.light)
            }
            .frame(width: headerIconHeight, height: headerIconHeight)
            
            VStack {
                Text("\(habit.name)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.subheadline.weight(.medium))
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                let nextTask = habit.nextTaskToComplete(day: today)
                if habit.isCompleted(day: today) {
                    Text("✓ Done for today")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.caption.weight(.regular))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(.green)
                        .offset(CGSize(width: 0, height: -2))
                } else if nextTask != nil && nextTask!.description.trimmingCharacters(in: .whitespaces) != "" {
                    Text("\(nextTask!.description)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.caption.weight(.regular))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .offset(CGSize(width: 0, height: -2))
                }
            }
            .frame(maxWidth: .infinity)
            
            MarkHabitButton(habit: habit)
        }
        .frame(height: headerHeight)
    }
}
