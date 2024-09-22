import Foundation

protocol HabitReminder: AnyObject {
    var id: UUID { get set }
    var habitId: UUID { get set }
    var timeOfDay: Int { get set }
    var sunday: Bool { get set }
    var monday: Bool { get set }
    var tuesday: Bool { get set }
    var wednesday: Bool { get set }
    var thursday: Bool { get set }
    var friday: Bool { get set }
    var saturday: Bool { get set }
    
    func validate() -> Bool
    func equals(_ habitReminder: HabitReminder) -> Bool
    func copyFrom(_ habitReminder: HabitReminder) -> Void
}

extension HabitReminder {
    func validate() -> Bool {
        return (
            sunday || monday || tuesday || wednesday ||
            thursday || friday || saturday
        )
    }
    
    func equals(_ habitReminder: HabitReminder) -> Bool {
        id == habitReminder.id &&
        habitId == habitReminder.habitId &&
        timeOfDay == habitReminder.timeOfDay &&
        sunday == habitReminder.sunday &&
        monday == habitReminder.monday &&
        tuesday == habitReminder.tuesday &&
        wednesday == habitReminder.wednesday &&
        thursday == habitReminder.thursday &&
        friday == habitReminder.friday &&
        saturday == habitReminder.saturday
    }
    
    func copyFrom(_ habitReminder: HabitReminder) {
        self.id = habitReminder.id
        self.habitId = habitReminder.habitId
        self.timeOfDay = habitReminder.timeOfDay
        self.sunday = habitReminder.sunday
        self.monday = habitReminder.monday
        self.tuesday = habitReminder.tuesday
        self.wednesday = habitReminder.wednesday
        self.thursday = habitReminder.thursday
        self.friday = habitReminder.friday
        self.saturday = habitReminder.saturday
    }
}
