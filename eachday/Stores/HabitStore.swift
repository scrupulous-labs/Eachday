import Foundation

@Observable
class HabitStore: Store {
    var all: [HabitModel] = []
    
    var sorted: [HabitModel] {
        all.filter { $0.showInUI && !$0.archived }.sorted { $0.sortOrder < $1.sortOrder }
    }
    
    var archived: [HabitModel] {
        all.filter { $0.showInUI && $0.archived }.sorted { $0.sortOrder < $1.sortOrder }
    }
    
    var filtered: [HabitModel] {
        let selectedGroups = rootStore.habitGroups.selected
        return sorted.filter { habit in
            let groupIds = habit.habitGroupItems.map { $0.groupId }
            let inActiveGroups = groupIds.contains { selectedGroups.contains($0) }
            return selectedGroups.isEmpty || inActiveGroups
        }
    }
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
