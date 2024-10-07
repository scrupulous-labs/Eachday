import Foundation

@Observable
class HabitGroupStore: Store {
    var all: [HabitGroupModel] = []
    var selected: Set<UUID> = Set<UUID>()
    
    var sorted: [HabitGroupModel] {
        all.filter { $0.showInUI }.sorted { $0.sortOrder < $1.sortOrder }
    }
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
