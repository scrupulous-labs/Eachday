import Foundation

protocol ReminderNotification: AnyObject {
    var reminderId: UUID { get set }
    var sundayId: UUID { get set }
    var mondayId: UUID { get set }
    var tuesdayId: UUID { get set }
    var wednesdayId: UUID { get set }
    var thursdayId: UUID { get set }
    var fridayId: UUID { get set }
    var saturdayId: UUID { get set }
    
    func validate() -> Bool
    func equals(_ reminderNotification: ReminderNotification) -> Bool
    func copyFrom(_ reminderNotification: ReminderNotification) -> Void
}

extension ReminderNotification {
    func validate() -> Bool {
        return true
    }
    
    func equals(_ reminderNotification: ReminderNotification) -> Bool {
        reminderId == reminderNotification.reminderId &&
        sundayId == reminderNotification.sundayId &&
        mondayId == reminderNotification.mondayId &&
        tuesdayId == reminderNotification.tuesdayId &&
        wednesdayId == reminderNotification.wednesdayId &&
        thursdayId == reminderNotification.thursdayId &&
        fridayId == reminderNotification.fridayId &&
        saturdayId == reminderNotification.saturdayId
    }
    
    func copyFrom(_ reminderNotification: ReminderNotification){
        self.reminderId = reminderNotification.reminderId
        self.sundayId = reminderNotification.sundayId
        self.mondayId = reminderNotification.mondayId
        self.tuesdayId = reminderNotification.tuesdayId
        self.wednesdayId = reminderNotification.wednesdayId
        self.thursdayId = reminderNotification.thursdayId
        self.fridayId = reminderNotification.fridayId
        self.saturdayId = reminderNotification.saturdayId
    }
}
