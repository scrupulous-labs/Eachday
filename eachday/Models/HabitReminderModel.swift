import Foundation
import UserNotifications

@Observable
class HabitReminderModel: Model<HabitReminderRecord>, HabitReminder {
    var id: UUID
    var habitId: UUID
    var timeOfDay: TimeOfDay
    var sunday: Bool
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool
    var habit: HabitModel? = nil
    var notification: ReminderNotificationModel? = nil
    var notificationUI: ReminderNotificationModel {
        notification ?? ReminderNotificationModel(rootStore, reminderId: id)
    }
    
    init(_ rootStore: RootStore, fromRecord: HabitReminderRecord) {
        self.id = fromRecord.id
        self.habitId = fromRecord.habitId
        self.timeOfDay = fromRecord.timeOfDay
        self.sunday = fromRecord.sunday
        self.monday = fromRecord.monday
        self.tuesday = fromRecord.tuesday
        self.wednesday = fromRecord.wednesday
        self.thursday = fromRecord.thursday
        self.friday = fromRecord.friday
        self.saturday = fromRecord.saturday
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ rootStore: RootStore, habitId: UUID, markForDeletion: Bool = false) {
        self.id = UUID()
        self.habitId = habitId
        self.timeOfDay = TimeOfDay(value: 8 * 60 + 30) // 8:30 AM
        self.sunday = true
        self.monday = true
        self.tuesday = false
        self.wednesday = false
        self.thursday = false
        self.friday = false
        self.saturday = false
        super.init(rootStore, fromRecord: nil, markForDeletion: markForDeletion)
    }
    
//
// MARK - FOR UI
//
    var time: Date {
        get { timeOfDay.toDate() }
        set { timeOfDay = TimeOfDay.fromDate(newValue) }
    }
    
    func isActive(day: WeekDay) -> Bool {
        switch day {
        case .sunday:
            return sunday
        case .monday:
            return monday
        case .tuesday:
            return tuesday
        case .wednesday:
            return wednesday
        case .thursday:
            return thursday
        case .friday:
            return friday
        case .saturday:
            return saturday
        }
    }
    
    func toggleDay(day: WeekDay) {
        switch day {
        case .sunday:
            sunday = !sunday
        case .monday:
            monday = !monday
        case .tuesday:
            tuesday = !tuesday
        case .wednesday:
            wednesday = !wednesday
        case .thursday:
            thursday = !thursday
        case .friday:
            friday = !friday
        case .saturday:
            saturday = !saturday
        }
    }

//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { [notificationUI] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }
    
    override func toRecord() -> HabitReminderRecord { HabitReminderRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() {
        habit = rootStore.habits.all.first { $0.id == habitId }
        notification = rootStore.reminderNotifications.all.first { $0.reminderId == id }
        
        habit?.habitReminders.append(self)
        notification?.habitReminder = self
        rootStore.habitReminders.all.append(self)
    }
    override func onSave() {
        Task { await registerNotifications() }
    }
    override func onUpdate() {
        Task { await registerNotifications() }
    }
    override func onDelete() {
        habit?.habitReminders.removeAll { $0.id == id }
        notification?.habitReminder = nil
        rootStore.habitReminders.all.removeAll { $0.id == id }
        cancelAllNotifications()
    }


//
// MARK - NOTIFICATIONS
//
    private func registerNotifications() async {
        let notificationCenter = UNUserNotificationCenter.current()
        let calendar = Calendar.current
        let content = UNMutableNotificationContent()
        content.title = habit?.name ?? "HABIT"
        content.sound = .default
        
        cancelAllNotifications()
        for day in daysToNotify() {
            var dateComponents = DateComponents()
            dateComponents.calendar = calendar
            dateComponents.hour = timeOfDay.hour
            dateComponents.minute = timeOfDay.minute
            dateComponents.weekday = day.rawValue
            
            do {
                try await notificationCenter.add(UNNotificationRequest(
                    identifier: notificationIdentifier(day: day),
                    content: content,
                    trigger: UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                ))
            } catch let error {
                print(error)
            }
        }
    }
    
    private func cancelAllNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        let notificationIds = WeekDay.allCases.map(notificationIdentifier)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: notificationIds)
    }
    
    private func daysToNotify() -> [WeekDay] {
        var result: [WeekDay] = []
        if sunday { result.append(.sunday) }
        if monday { result.append(.monday) }
        if tuesday { result.append(.tuesday) }
        if wednesday { result.append(.wednesday) }
        if thursday { result.append(.thursday) }
        if friday { result.append(.friday) }
        if saturday { result.append(.saturday) }
        return result
    }
    
    private func notificationIdentifier(day: WeekDay) -> String {
        let notificationId = switch day {
            case .sunday:
                notificationUI.sundayId
            case .monday:
                notificationUI.mondayId
            case .tuesday:
                notificationUI.tuesdayId
            case .wednesday:
                notificationUI.wednesdayId
            case .thursday:
                notificationUI.thursdayId
            case .friday:
                notificationUI.fridayId
            case .saturday:
                notificationUI.saturdayId
        }
        return notificationId.uuidString.lowercased()
    }
}
