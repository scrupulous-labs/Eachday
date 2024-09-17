import Foundation

enum EditHabitGroupFormField: Hashable {
    case groupName
    
    static func == (lhs: EditHabitGroupFormField, rhs: EditHabitGroupFormField) -> Bool {
        switch (lhs, rhs) {
        case (.groupName, .groupName):
            return true
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .groupName:
            hasher.combine("groupName")
        }
    }
}
