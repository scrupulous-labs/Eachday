import Foundation

@Observable
class HabitTaskStore: Store {
    var all: [HabitTaskModel] = []
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
