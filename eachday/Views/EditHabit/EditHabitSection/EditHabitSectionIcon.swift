import SwiftUI

struct EditHabitSectionIcon: View {
    let habit: Habit
    let onMoreIcons: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var gridItemWidth = 36.0
    var gridColumnCount = 7
    var gridVerticalSpacing = 12.0
    var gridHorizontalSpacing = 12.0
    var cellSize = 36.0
    var cellCornerRadius = 6.0
    
    var body: some View {
        Section {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.fixed(gridItemWidth), spacing: gridHorizontalSpacing),
                    count: gridColumnCount
                ),
                spacing: gridVerticalSpacing
            ) {
                ForEach(HabitIconGroup.sportsAndFitness.icons(), id: \.rawValue) { icon in
                    ZStack {
                        RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                            .size(width: cellSize, height: cellSize)
                            .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#262626"))
                        Image(systemName: icon.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .fontWeight(.light)
                        
                        if habit.icon == icon {
                            RoundedRectangle(cornerRadius: cellCornerRadius + 2, style: .continuous)
                                .size(width: cellSize + 6, height: cellSize + 6)
                                .stroke(colorScheme == .light ? .black : .white, lineWidth: 2)
                                .offset(x: -3, y: -3)
                        }
                    }
                    .frame(width: cellSize, height: cellSize)
                    .onTapGesture { habit.icon = icon }
                }
            }
        } header: {
            Button { onMoreIcons() } label: {
                HStack(spacing: 4) {
                    Text("More Icons")
                        .font(Font.subheadline)
                        .textCase(nil)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 2)
                .padding(.trailing, -18)
            }
        }
    }
}
