import SwiftUI

struct EditHabitSetReminders: View {
    var habit: HabitModel
    @Bindable var reminder: HabitReminderModel
    var onSaveReminder: () -> Void
    
    var cellSize = 40.0
    var cellCornerRadius = 6.0
    var daysOfWeek: [DayOfWeek] {
        let startOfWeek = modelGraph.settingsUI.startOfWeek
        return [
            startOfWeek,
            startOfWeek.next(),
            startOfWeek.next().next(),
            startOfWeek.next().next().next(),
            startOfWeek.next().next().next().next(),
            startOfWeek.next().next().next().next().next(),
            startOfWeek.next().next().next().next().next().next()
        ]
    }
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        List {
            Section {
                ForEach(Array(habit.habitRemindersUI), id: \.id) { reminder in
                    @Bindable var reminder = reminder
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 16) {
                            DatePicker("", selection: $reminder.time, displayedComponents: .hourAndMinute).labelsHidden()
                            dayOfWeek(reminder: reminder)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Menu {
                            Button { reminder.markForDeletion() } label: {
                                Label("Delete", systemImage: "trash").foregroundColor(.red)
                            }
                        } label: {
                            ZStack {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .fontWeight(.regular)
                                    .offset(x: 8, y: 0)
                            }
                            .frame(width: cellSize, height: cellSize)
                        }
                    }
                }
            } header: {
                Text("Reminders")
            }
            
            Section {
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 16) {
                        DatePicker("", selection: $reminder.time, displayedComponents: .hourAndMinute).labelsHidden()
                        dayOfWeek(reminder: reminder)
                    }
                    .frame(maxWidth: .infinity)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                            .size(width: cellSize, height: cellSize)
                            .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#262626"))
                        
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .fontWeight(.regular)
                    }
                    .frame(width: cellSize, height: cellSize)
                    .onTapGesture { onSaveReminder() }
                }
            } header: {
                Text("Add Reminder")
            }
        }
    }
    
    func dayOfWeek(reminder: HabitReminderModel) -> some View {
        HStack(spacing: 10) {
            ForEach(daysOfWeek, id: \.self) { dayOfWeek in
                let isActive = reminder.isActive(day: dayOfWeek)
                let background = isActive
                    ? (colorScheme == .light ? "#E5E5E5" : "#404040")
                    : (colorScheme == .light ? "#FAFAFA" : "#27272A")
                let foreGround = isActive
                    ? (colorScheme == .light ? "#000000" : "#FFFFFF")
                    : (colorScheme == .light ? "#000000" : "#FFFFFF")
                
                ZStack {
                    RoundedRectangle(cornerRadius: 200.0)
                        .fill(Color(hex: background))
                        .frame(width: 32, height: 32)
                    
                    Text("\(dayOfWeek.shortHand())")
                        .font(Font.caption.weight(.medium))
                        .foregroundColor(Color(hex: foreGround))
                }
                .frame(width: 32, height: 32)
                .onTapGesture { reminder.toggleDay(day: dayOfWeek) }
            }
        }
    }
}
