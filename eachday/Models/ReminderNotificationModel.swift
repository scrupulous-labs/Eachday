import Foundation

@Observable
class ReminderNotificationModel: Model<ReminderNotificationRecord>, ReminderNotification {
    var reminderId: UUID
    var sundayId: UUID
    var mondayId: UUID
    var tuesdayId: UUID
    var wednesdayId: UUID
    var thursdayId: UUID
    var fridayId: UUID
    var saturdayId: UUID
    var habitReminder: HabitReminderModel? = nil
    
    init(_ rootStore: RootStore, fromRecord: ReminderNotificationRecord) {
        self.reminderId = fromRecord.reminderId
        self.sundayId = fromRecord.sundayId
        self.mondayId = fromRecord.mondayId
        self.tuesdayId = fromRecord.tuesdayId
        self.wednesdayId = fromRecord.wednesdayId
        self.thursdayId = fromRecord.thursdayId
        self.fridayId = fromRecord.fridayId
        self.saturdayId = fromRecord.saturdayId
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ rootStore: RootStore, reminderId: UUID, markForDeletion: Bool = false) {
        self.reminderId = reminderId
        self.sundayId = UUID() 
        self.mondayId = UUID()
        self.tuesdayId = UUID()  
        self.wednesdayId = UUID() 
        self.thursdayId = UUID()  
        self.fridayId = UUID() 
        self.saturdayId = UUID() 
        super.init(rootStore, fromRecord: nil, markForDeletion: markForDeletion)
    }
    
//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }
    
    override func toRecord() -> ReminderNotificationRecord { ReminderNotificationRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() {
        habitReminder = rootStore.habitReminders.all.first { $0.id == reminderId }
        
        habitReminder?.notification = self
        rootStore.reminderNotifications.all.append(self)
    }
    override func onDelete() {
        habitReminder?.notification = nil
        rootStore.reminderNotifications.all.removeAll { $0.reminderId == reminderId }
    }
}
