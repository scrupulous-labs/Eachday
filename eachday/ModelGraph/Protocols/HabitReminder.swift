import Foundation

protocol HabitReminder: AnyObject {
    var id: UUID { get set }
    var habitId: UUID { get set }
    var dayOfWeek: DayOfWeek { get set }
    var timeOfDay: Int { get set }
    
    func validate() -> Bool
    func equals(_ habitReminder: HabitReminder) -> Bool
    func copyFrom(_ habitReminder: HabitReminder) -> Void
}

extension HabitReminder {
    func validate() -> Bool {
        return true
    }
    
    func equals(_ habitReminder: HabitReminder) -> Bool {
        id == habitReminder.id &&
        habitId == habitReminder.habitId &&
        dayOfWeek == habitReminder.dayOfWeek &&
        timeOfDay == habitReminder.timeOfDay
    }
    
    func copyFrom(_ habitReminder: HabitReminder) {
        self.id = habitReminder.id
        self.habitId = habitReminder.habitId
        self.dayOfWeek = habitReminder.dayOfWeek
        self.timeOfDay = habitReminder.timeOfDay
    }
}
