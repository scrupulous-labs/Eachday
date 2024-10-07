import Foundation

@Observable
class HabitReminderStore: Store {
    var all: [HabitReminderModel] = []
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
