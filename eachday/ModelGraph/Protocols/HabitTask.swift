import Foundation

protocol HabitTask: AnyObject {
    var id: UUID { get set}
    var habitId: UUID { get set }
    var description: String { get set }
    var sortOrder: SortOrder { get set }
    
    func validate() -> Bool
    func equals(_ task: HabitTask) -> Bool
    func copyFrom(_ task: HabitTask) -> Void
}

extension HabitTask {
    func validate() -> Bool {
        description.trimmingCharacters(in: .whitespaces) != ""
    }
    
    func equals(_ task: HabitTask) -> Bool {
        id == task.id &&
        habitId == task.habitId &&
        description == task.description &&
        sortOrder == task.sortOrder
    }
    
    func copyFrom(_ task: HabitTask) {
        self.id = task.id
        self.habitId = task.habitId
        self.description = task.description
        self.sortOrder = task.sortOrder
    }
}
