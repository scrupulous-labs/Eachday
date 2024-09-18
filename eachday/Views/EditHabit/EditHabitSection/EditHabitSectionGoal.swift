import SwiftUI

struct EditHabitSectionGoal: View {
    @Bindable var habit: HabitModel
    @FocusState.Binding var focusedField: EditHabitFormField?
    var onFieldChange: () -> Void
    var onChangeFrequency: () -> Void
    var onChangeReminders: () -> Void
    var onChangeGroup: () -> Void
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Section {
            Button {
                focusedField = nil
                onChangeFrequency()
            } label: {
                HStack {
                    Text("Frequency")
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(habit.frequency.uiText())
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                        .padding(.trailing, -2)
                }
            }
            
            Button { 
                focusedField = nil
                onChangeReminders()
            } label: {
                HStack {
                    Text("Reminders")
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("2")
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                        .padding(.trailing, -2)
                }
            }
            
            Button {
                focusedField = nil
                onChangeGroup()
            } label: {
                let text = habit.habitGroupItems.isEmpty ? "None" : "\(habit.habitGroupItems.count)"
                HStack {
                    Text("Groups")
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(text)
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                        .padding(.trailing, -2)
                }
            }
        } header: {
            Text("YOUR GOAL").padding(.leading, -8)
        } footer: {
            Text("This data will be used to calculate your streaks")
        }
    }
}
