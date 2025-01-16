import Foundation

@Observable
class ReminderNotificationStore: Store {
    var all: [ReminderNotificationModel] = []
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
