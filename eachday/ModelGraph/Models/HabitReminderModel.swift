import Foundation
import UserNotifications

@Observable
class HabitReminderModel: Model<HabitReminderRecord>, HabitReminder {
    var id: UUID
    var habitId: UUID
    var timeOfDay: Int
    var sunday: Bool
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool
    var habit: HabitModel? = nil
    var notification: ReminderNotificationModel? = nil
    
    var hours: Int {
        timeOfDay / 60
    }
    var minutes: Int {
        timeOfDay % 60
    }
    var notificationUI: ReminderNotificationModel {
        notification ?? ReminderNotificationModel(modelGraph, reminderId: id)
    }
    
    init(_ modelGraph: ModelGraph, fromRecord: HabitReminderRecord) {
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
        super.init(modelGraph, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ modelGraph: ModelGraph, habitId: UUID, markForDeletion: Bool = false) {
        self.id = UUID()
        self.habitId = habitId
        self.timeOfDay = 12 * 60
        self.sunday = false
        self.monday = false
        self.tuesday = false
        self.wednesday = false
        self.thursday = false
        self.friday = false
        self.saturday = false
        super.init(modelGraph, fromRecord: nil, markForDeletion: markForDeletion)
    }
    
//
// MARK - FOR UI
//
    var time: Date {
        get { fromTimeOfDay(timeOfDay: timeOfDay) }
        set { timeOfDay = toTimeOfDay(date: newValue ) }
    }
    
    func isActive(day: DayOfWeek) -> Bool {
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
    
    func toggleDay(day: DayOfWeek) {
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
// MARK - NOTIFICATIONS
//
    func registerNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        let calendar = Calendar.current
        let content = UNMutableNotificationContent()
        content.title = habit?.name ?? "HABIT"
        content.sound = .default
        
        cancelAllNotifications()
        for day in allNotificationDays() {
            var dateComponents = DateComponents()
            dateComponents.calendar = calendar
            dateComponents.hour = hours
            dateComponents.minute = minutes
            dateComponents.weekday = day.rawValue

            notificationCenter.add(UNNotificationRequest(
                identifier: notificationIdentifier(day: day),
                content: content,
                trigger: UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            ))
            
            print("Date \(dateComponents.weekday!) \(dateComponents.hour!)-\(dateComponents.minute!), \(notificationIdentifier(day: day))")
        }
    }
    
    func cancelAllNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: allNotificationIdentifiers())
    }
    
//
// MARK - UTILS
//
    func toTimeOfDay(date: Date) -> Int {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        if let hour = dateComponents.hour, let minute = dateComponents.minute {
            print("Hour \(hour) minute \(minute)")
            return hour * 60 + minute
        } else {
            return 12 * 60
        }
    }
    
    func fromTimeOfDay(timeOfDay: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = 1
        dateComponents.year = 2024
        dateComponents.hour = timeOfDay / 60
        dateComponents.minute = timeOfDay % 60
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date.now
        }
    }
    
    func allNotificationIdentifiers() -> [String] {
        return DayOfWeek.allCases.map(notificationIdentifier)
    }
    
    func allNotificationDays() -> [DayOfWeek] {
        var result: [DayOfWeek] = []
        if sunday { result.append(.sunday) }
        if monday { result.append(.monday) }
        if tuesday { result.append(.tuesday) }
        if wednesday { result.append(.wednesday) }
        if thursday { result.append(.thursday) }
        if friday { result.append(.friday) }
        if saturday { result.append(.saturday) }
        return result
    }
    
    func notificationIdentifier(day: DayOfWeek) -> String {
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

//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { notification != nil ? [notificationUI] : [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }
    
    override func toRecord() -> HabitReminderRecord { HabitReminderRecord(fromModel: self) }
    override func addToGraph() {
        habit = modelGraph.habits.first { $0.id == habitId }
        notification = modelGraph.reminderNotifications.first { $0.reminderId == id }
        
        habit?.habitReminders.append(self)
        notification?.habitReminder = self
        modelGraph.habitReminders.append(self)
    }
    override func removeFromGraph() {
        habit?.habitReminders.removeAll { $0.id == id }
        notification?.habitReminder = nil
        modelGraph.habitReminders.removeAll { $0.id == id }
    }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    
    override func preSave() { registerNotifications() }
    override func preUpdate() { registerNotifications() }
    override func preDelete() { cancelAllNotifications() }
}
