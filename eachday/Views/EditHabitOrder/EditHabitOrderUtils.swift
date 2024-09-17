import Foundation

enum EditHabitOrderSheet: Identifiable {
    case editHabitGroupOrder
    case editHabitGroup(HabitGroupModel)
    
    var id: String {
        switch self {
        case .editHabitGroupOrder:
            return "EditHabitGroupOrder"
        case .editHabitGroup(let model):
            return "NewHabitGroup \(model.id.uuidString)"
        }
    }
}
