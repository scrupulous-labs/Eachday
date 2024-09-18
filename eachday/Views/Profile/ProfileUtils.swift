import Foundation

enum ProfileViewScreen: Hashable {
    case editHabitOrder
    case archivedHabits
    
    static func == (lhs: ProfileViewScreen, rhs: ProfileViewScreen) -> Bool {
        switch (lhs, rhs) {
        case (.editHabitOrder, .editHabitOrder):
            return true
        case (.archivedHabits, .archivedHabits):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .editHabitOrder:
            hasher.combine("editHabitOrder")
        case .archivedHabits:
            hasher.combine("archivedHabits")
        }
    }
}
