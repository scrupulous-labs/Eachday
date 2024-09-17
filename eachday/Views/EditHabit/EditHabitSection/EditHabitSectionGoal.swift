import SwiftUI

struct EditHabitSectionGoal: View {
    @Bindable var habit: HabitModel
    @FocusState.Binding var focusedField: EditHabitFormField?
    var onFieldChange: () -> Void
    var onChangeFrequency: () -> Void
    var onChangeReminders: () -> Void
    var onChangeGroup: () -> Void

    var body: some View {
        Section {
            HStack {
                Text("Frequency")
                    .font(Font.subheadline.weight(.regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text(habit.frequency.uiText())
                        .font(Font.subheadline.weight(.regular))
                }
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color(hex: "#9CA3AF"))
                    .padding(.trailing, -2)
            }
            .onTapGesture {
                focusedField = nil
                onChangeFrequency()
            }
            
//            HStack {
//                Text("Reminders")
//                    .font(Font.subheadline.weight(.regular))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                HStack {
//                    Text("2")
//                        .font(Font.subheadline.weight(.regular))
//                }
//                Image(systemName: "chevron.right")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 12, height: 12)
//                    .foregroundColor(Color(hex: "#9CA3AF"))
//                    .padding(.trailing, -2)
//            }
//            .onTapGesture {
//                focusedField = nil
//                onChangeReminders()
//            }
            
            HStack {
                Text("Group")
                    .font(Font.subheadline.weight(.regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text(habit.nonDefaultGroup?.name ?? "None" )
                        .font(Font.subheadline.weight(.regular))
                }
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color(hex: "#9CA3AF"))
                    .padding(.trailing, -2)
            }
            .onTapGesture {
                focusedField = nil
                onChangeGroup()
            }
            
        } header: {
            Text("YOUR GOAL").padding(.leading, -8)
        } footer: {
            Text("This data will be used to calculate your streaks")
        }
    }
}
