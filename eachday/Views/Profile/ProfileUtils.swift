import Foundation

enum ProfileViewScreen: Hashable {
    case purchasePro
    case reorderHabits
    case archivedHabits
    
    static func == (lhs: ProfileViewScreen, rhs: ProfileViewScreen) -> Bool {
        switch (lhs, rhs) {
        case (.purchasePro, .purchasePro):
            return true
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
        case .purchasePro:
            hasher.combine("purchasePro")
        case .reorderHabits:
            hasher.combine("reorderHabitsz")
        case .archivedHabits:
            hasher.combine("archivedHabits")
        }
    }
}
