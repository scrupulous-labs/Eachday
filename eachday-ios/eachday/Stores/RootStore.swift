import Foundation

@Observable
class RootStore {
    static func makeStore() throws -> RootStore {
        let database = Database.makeDb()
        let rootStore = RootStore(database: database)
        try rootStore.loadFromDb()
        return rootStore
    }
    
    let database: Database
    private(set) var habits: HabitStore! = nil
    private(set) var habitTasks: HabitTaskStore! = nil
    private(set) var habitGroups: HabitGroupStore! = nil
    private(set) var habitGroupItems: HabitGroupItemStore! = nil
    private(set) var taskCompletions: TaskCompletionStore! = nil
    private(set) var habitReminders: HabitReminderStore! = nil
    private(set) var reminderNotifications: ReminderNotificationStore! = nil
    private(set) var settings: SettingsStore! = nil
    private(set) var purchases: PurchaseStore! = nil
    
    init(database: Database) {
        self.database = database
        self.habits = HabitStore(self)
        self.habitTasks = HabitTaskStore(self)
        self.habitGroups = HabitGroupStore(self)
        self.habitGroupItems = HabitGroupItemStore(self)
        self.taskCompletions = TaskCompletionStore(self)
        self.habitReminders = HabitReminderStore(self)
        self.reminderNotifications = ReminderNotificationStore(self)
        self.settings = SettingsStore(self)
        self.purchases = PurchaseStore(self)
    }
    
    func loadFromDb() throws {
        try database.reader.read { db in
            _ = try HabitRecord.fetchAll(db).map { HabitModel(self, fromRecord: $0) }
            _ = try HabitTaskRecord.fetchAll(db).map { HabitTaskModel(self, fromRecord: $0) }
            _ = try HabitGroupRecord.fetchAll(db).map { HabitGroupModel(self, fromRecord: $0) }
            _ = try HabitGroupItemRecord.fetchAll(db).map { HabitGroupItemModel(self, fromRecord: $0) }
            _ = try TaskCompletionRecord.fetchAll(db).map { TaskCompletionModel(self, fromRecord: $0) }
            _ = try HabitReminderRecord.fetchAll(db).map { HabitReminderModel(self, fromRecord: $0) }
            _ = try ReminderNotificationRecord.fetchAll(db).map { ReminderNotificationModel(self, fromRecord: $0) }
            _ = try SettingsRecord.fetchAll(db).map { SettingsModel(self, fromRecord: $0) }
        }
    }
}
