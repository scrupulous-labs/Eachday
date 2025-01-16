import SwiftUI

struct EditHabitSectionHabit: View {
    @Bindable var habit: HabitModel
    @FocusState.Binding var focusedField: EditHabitFormField?
    var onFieldChange: () -> Void
    var onIconChange: () -> Void
    
    var cellSize = 40.0
    var cellCornerRadius = 6.0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Section {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                        .size(width: cellSize, height: cellSize)
                        .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#262626"))
                    
                    Image(systemName: colorScheme == .light ? habit.icon.symbol : habit.icon.symbolDark)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .fontWeight(.light)
                }
                .frame(width: cellSize, height: cellSize)
                .onTapGesture { onIconChange() }
                
                TextField("Name", text: $habit.name)
                    .onChange(of: habit.name, onFieldChange)
                    .focused($focusedField, equals: EditHabitFormField.habitName)
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 8)
            .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        } header: {
            Text("HABIT").padding(.leading, -8)
        }
    }
}
