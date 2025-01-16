import Foundation

@Observable
class HabitGroupItemStore: Store {
    var all: [HabitGroupItemModel] = []
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
