import Foundation

enum AppViewSheet: Identifiable {
    case profileSheet
    case editHabitSheet(HabitModel)
    case editHabitHistorySheet(HabitModel)
    
    var id: String {
        switch self {
        case .profileSheet:
            return "profileSheet"
        case .editHabitSheet(let habit):
            return "editHabitSheet \(habit.id.uuidString)"
        case .editHabitHistorySheet(let habit):
            return "editHabitHistorySheet \(habit.id.uuidString)"
        }
    }
}

enum AppViewScreen: Hashable {
    case habitDetailsScreen(habitId: UUID)
    
    static func == (lhs: AppViewScreen, rhs: AppViewScreen) -> Bool {
        switch (lhs, rhs) {
        case (.habitDetailsScreen(let id1), .habitDetailsScreen(let id2)):
            return id1 == id2
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .habitDetailsScreen(let habitId):
            hasher.combine(habitId)
        }
    }
}
