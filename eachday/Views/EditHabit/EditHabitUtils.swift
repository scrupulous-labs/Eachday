import Foundation

enum EditHabitSheet: Identifiable {
    case selectFrequencySheet
    case editGroupSheet(HabitGroupModel)
    
    var id: String {
        switch self {
        case .selectFrequencySheet:
            return "selectFrequencySheet"
        case .editGroupSheet(let group):
            return "editGroupSheet \(group.id.uuidString)"
        }
    }
}

enum EditHabitScreen: Hashable {
    case setRemindersScreen
    case selectGroupScreen
    case selectIconScreen
    
    static func == (lhs: EditHabitScreen, rhs: EditHabitScreen) -> Bool {
        switch (lhs, rhs) {
        case (.setRemindersScreen, .setRemindersScreen):
            return true
        case (.selectGroupScreen, .selectGroupScreen):
            return true
        case (.selectIconScreen, .selectIconScreen):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .setRemindersScreen:
            hasher.combine("setRemindersScreen")
        case .selectGroupScreen:
            hasher.combine("selectGroupScreen")
        case .selectIconScreen:
            hasher.combine("selectIconScreen")
        }
    }
}

enum EditHabitFormField: Hashable {
    case habitName
    case taskDescription(HabitTask)
    
    static func == (lhs: EditHabitFormField, rhs: EditHabitFormField) -> Bool {
        switch (lhs, rhs) {
        case (.habitName, .habitName):
            return true
        case (.taskDescription(let t1), .taskDescription(let t2)):
            return t1.id == t2.id
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .habitName:
            hasher.combine("habitName")
        case .taskDescription(let task):
            hasher.combine("taskDescription")
            hasher.combine(task.id)
        }
    }
}
