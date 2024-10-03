import SwiftUI

struct EditHabitSelectIcon: View {
    var habit: HabitModel
    var onFieldChange: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Common Activites",
                    icons: HabitIconGroup.commonActivites.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Food and Celebrations",
                    icons: HabitIconGroup.foodAndCelebrations.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Work and Study",
                    icons: HabitIconGroup.workAndStudy.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Sports and Fitness",
                    icons: HabitIconGroup.sportsAndFitness.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Nature and Animals",
                    icons: HabitIconGroup.natureAndAnimals.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Art and Creativity",
                    icons: HabitIconGroup.artsAndCreativity.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Home",
                    icons: HabitIconGroup.home.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Travel",
                    icons: HabitIconGroup.travel.icons(),
                    onFieldChange: onFieldChange
                )
                
                EditHabitSelectIconGrid(
                    habit: habit,
                    title: "Shapes and Emojis",
                    icons: HabitIconGroup.shapesAndEmojis.icons(),
                    onFieldChange: onFieldChange
                )
            }
            .padding(.top, 16)
        }
    }
}

struct EditHabitSelectIconGrid: View {
    var habit: HabitModel
    var title: String
    var icons: [HabitIcon]
    var onFieldChange: () -> Void
    
    var gridItemWidth = 38.0
    var gridColumnCount = 8
    var gridVerticalSpacing = 16.0
    var gridHorizontalSpacing = 8.0
    var cellSize = 38.0
    var cellCornerRadius = 6.0
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(Font.subheadline.weight(.light))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.fixed(gridItemWidth), spacing: gridHorizontalSpacing),
                    count: gridColumnCount
                ),
                spacing: gridVerticalSpacing
            ) {
                ForEach(icons, id: \.rawValue) { icon in
                    ZStack {
                        RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                            .size(width: cellSize, height: cellSize)
                            .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#171717"))
                        Image(systemName: colorScheme == .light ? icon.symbol : icon.symbolDark)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .fontWeight(.light)
                            .frame(width: 22, height: 22)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                        
                        if habit.icon == icon {
                            RoundedRectangle(cornerRadius: cellCornerRadius + 2, style: .continuous)
                                .size(width: cellSize + 6, height: cellSize + 6)
                                .stroke(colorScheme == .light ? .black : .white, lineWidth: 2)
                                .offset(x: -3, y: -3)
                        }
                    }
                    .frame(width: cellSize, height: cellSize)
                    .onTapGesture {
                        habit.icon = icon
                        onFieldChange()
                        dismiss()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
