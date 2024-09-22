import Foundation

protocol HabitGroupItem: AnyObject {
    var id: UUID { get set }
    var habitId: UUID { get set }
    var groupId: UUID { get set }
    
    func validate() -> Bool
    func equals(_ habitGroupItem: HabitGroupItem) -> Bool
    func copyFrom(_ habitGroupItem: HabitGroupItem) -> Void
}

extension HabitGroupItem {
    func validate() -> Bool {
        return true
    }
    
    func equals(_ habitGroupItem: HabitGroupItem) -> Bool {
        id == habitGroupItem.id &&
        habitId == habitGroupItem.habitId &&
        groupId == habitGroupItem.groupId
    }
    
    func copyFrom(_ habitGroupItem: HabitGroupItem) {
        self.id = habitGroupItem.id
        self.habitId = habitGroupItem.habitId
        self.groupId = habitGroupItem.groupId
    }
}
