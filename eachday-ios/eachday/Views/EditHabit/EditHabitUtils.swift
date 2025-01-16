import Foundation

enum EditHabitSheet: Identifiable {
    case selectFrequencySheet
    
    var id: String {
        switch self {
        case .selectFrequencySheet:
            return "selectFrequencySheet"
        }
    }
}

enum EditHabitScreen: Hashable {
    case setRemindersScreen
    case selectGroupScreen(HabitGroupModel)
    case selectIconScreen
    
    static func == (lhs: EditHabitScreen, rhs: EditHabitScreen) -> Bool {
        switch (lhs, rhs) {
        case (.setRemindersScreen, .setRemindersScreen):
            return true
        case (.selectGroupScreen(let group1), .selectGroupScreen(let group2)):
            return group1.id == group2.id
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
        case .selectGroupScreen(let group):
            hasher.combine("selectGroupScreen \(group.id.uuidString)")
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
