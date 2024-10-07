import SwiftUI
import UserNotifications

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
                    Text(habit.frequency.uiText)
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
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .sound, .badge]
                ) { success, error in
                    if let error = error {
                        print(error)
                    } else {
                        onChangeReminders()
                    }
                }
            } label: {
                HStack {
                    Text("Reminders")
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    RemindersMinimap(habit: habit)
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


struct RemindersMinimap: View {
    var habit: HabitModel
    
    var daysOfWeek: [WeekDay] {
        Week.allDays(
            startOfWeek: rootStore.settings.value.startOfWeek
        )
    }
    var activeDaysOfWeek: Set<WeekDay> {
        let reminders = habit.habitRemindersUI
        var result: Set<WeekDay> = Set()
        if reminders.contains(where: { $0.sunday }) {
            result.insert(.sunday)
        }
        if reminders.contains(where: { $0.monday }) {
            result.insert(.monday)
        }
        if reminders.contains(where: { $0.tuesday }) {
            result.insert(.tuesday)
        }
        if reminders.contains(where: { $0.wednesday }) {
            result.insert(.wednesday)
        }
        if reminders.contains(where: { $0.thursday }) {
            result.insert(.thursday)
        }
        if reminders.contains(where: { $0.friday }) {
            result.insert(.friday)
        }
        if reminders.contains(where: { $0.saturday }) {
            result.insert(.saturday)
        }
        return result
    }
    @Environment(\.colorScheme) var colorScheme
    @Environment(RootStore.self) var rootStore
    
    var body: some View {
        HStack(spacing: 6) {
            let activeDays = activeDaysOfWeek
            ForEach(daysOfWeek, id: \.self) { day in
                let isActive = activeDays.contains(day)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .light ? .black : .white, lineWidth: 0.5)
                    .fill(isActive ? .green : .white.opacity(0))
                    .frame(width: 12, height: 12)
            }
        }
    }
}
