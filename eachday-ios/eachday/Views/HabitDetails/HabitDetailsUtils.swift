import Foundation

enum HabitDetailsSheet: Identifiable {
    case editHabitSheet
    case editHabitHistorySheet
    
    var id: String {
        switch self {
        case .editHabitSheet:
            return "editHabitSheet"
        case .editHabitHistorySheet:
            return "editHabitHistorySheet"
        }
    }
}
