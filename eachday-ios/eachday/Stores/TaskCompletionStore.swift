import Foundation

@Observable
class TaskCompletionStore: Store {
    var all: [TaskCompletionModel] = []
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
