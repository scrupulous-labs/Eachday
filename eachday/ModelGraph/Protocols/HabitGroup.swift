import Foundation

protocol HabitGroup: AnyObject {
    var id: UUID { get set }
    var name: String { get set }
    var sortOrder: SortOrder { get set }
    var isDefault: Bool { get set }
    
    func validate() -> Bool
    func equals(_ habitGroup: HabitGroup) -> Bool
    func copyFrom(_ habitGroup: HabitGroup) -> Void
}

extension HabitGroup {
    func validate() -> Bool {
        name.trimmingCharacters(in: .whitespaces) != ""
    }
    
    func equals(_ habitGroup: HabitGroup) -> Bool {
        id == habitGroup.id &&
        name == habitGroup.name &&
        sortOrder == habitGroup.sortOrder &&
        isDefault == habitGroup.isDefault
    }
    
    func copyFrom(_ habitGroup: HabitGroup) {
        self.id = habitGroup.id
        self.name = habitGroup.name
    }
}
