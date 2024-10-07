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
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
