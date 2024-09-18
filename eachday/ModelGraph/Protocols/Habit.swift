import Foundation

enum HabitDayStatus: Equatable {
    case completed
    case notCompleted
    case partiallyCompleted(value: Double)
}

protocol Habit: AnyObject {
    var id: UUID { get set }
    var name: String { get set }
    var icon: HabitIcon { get set }
    var color: HabitColor { get set }
    var archived: Bool { get set }
    var frequency: Frequency { get set }
    var sortOrder: SortOrder { get set }
    
    func validate() -> Bool
    func equals(_ habit: Habit) -> Bool
    func copyFrom(_ habit: Habit) -> Void
}

extension Habit {
    func validate() -> Bool {
        name.trimmingCharacters(in: .whitespaces) != ""
    }
    
    func equals(_ habit: Habit) -> Bool {
        id == habit.id &&
        name == habit.name &&
        icon == habit.icon &&
        color == habit.color &&
        archived == habit.archived &&
        frequency == habit.frequency &&
        sortOrder == habit.sortOrder
    }
    
    func copyFrom(_ habit: Habit) {
        self.id = habit.id
        self.name = habit.name
        self.icon = habit.icon
        self.color = habit.color
        self.archived = habit.archived
        self.frequency = habit.frequency
        self.sortOrder = habit.sortOrder
    }
}
