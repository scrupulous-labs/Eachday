import Foundation

enum EditHabitGroupOrderSheet: Identifiable {
    case editHabitGroup(HabitGroupModel)
    
    var id: String {
        switch self {
        case .editHabitGroup(let habitGroup):
            return "EditHabitGroup \(habitGroup.id.uuidString)"
        }
    }
}
