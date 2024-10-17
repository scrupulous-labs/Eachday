import Foundation

enum ProfileViewScreen: Hashable {
    case reorderHabits
    case archivedHabits
    
    static func == (lhs: ProfileViewScreen, rhs: ProfileViewScreen) -> Bool {
        switch (lhs, rhs) {
        case (.reorderHabits, .reorderHabits):
            return true
        case (.archivedHabits, .archivedHabits):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .reorderHabits:
            hasher.combine("reorderHabits")
        case .archivedHabits:
            hasher.combine("archivedHabits")
        }
    }
}
