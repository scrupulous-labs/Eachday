import SwiftUI

struct EditHabitSectionHabit: View {
    @Bindable var habit: HabitModel
    @FocusState.Binding var focusedField: EditHabitFormField?
    var onFieldChange: () -> ()
    
    var body: some View {
        Section {
            TextField("Name", text: $habit.name)
                .onChange(of: habit.name, onFieldChange)
                .focused($focusedField, equals: EditHabitFormField.habitName)
        } header: {
            Text("HABIT").padding(.leading, -8)
        }
    }
}
