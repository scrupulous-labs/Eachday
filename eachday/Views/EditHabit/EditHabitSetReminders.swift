import SwiftUI

struct EditHabitSetReminders: View {
    var habit: HabitModel
    var onFieldChange: () -> Void
    
    var cellSize = 40.0
    var cellCornerRadius = 6.0
    var daysOfWeek: [WeekDay] {
        Week.allDays(
            startOfWeek: modelGraph.settingsUI.startOfWeek
        )
    }
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        List {
            Section {
                if habit.habitRemindersUI.isEmpty {
                    Text("No reminders")
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                ForEach(Array(habit.habitRemindersUI), id: \.id) { reminder in
                    @Bindable var reminder = reminder
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 16) {
                            DatePicker("", selection: $reminder.time, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .onChange(of: reminder.time, { _, _ in onFieldChange() })
                            renderWeekDays(reminder: reminder)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Menu {
                            Button { reminder.markForDeletion(); onFieldChange() } label: {
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
            
            Button {
                _ = HabitReminderModel(modelGraph, habitId: habit.id)
                onFieldChange()
            } label: {
                Text("NEW REMINDER")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func renderWeekDays(reminder: HabitReminderModel) -> some View {
        HStack(spacing: 10) {
            ForEach(daysOfWeek, id: \.self) { WeekDay in
                let isActive = reminder.isActive(day: WeekDay)
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
                    
                    Text("\(WeekDay.shortHand)")
                        .font(Font.caption.weight(.medium))
                        .foregroundColor(Color(hex: foreGround))
                }
                .frame(width: 32, height: 32)
                .onTapGesture {
                    reminder.toggleDay(day: WeekDay)
                    onFieldChange()
                }
            }
        }
    }
}
