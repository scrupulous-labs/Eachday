import Foundation

@Observable
class ModelGraph {
    static func makeGraph() throws -> ModelGraph {
        let database = Database.makeDb()
        let modelGraph = ModelGraph(database: database)
        try modelGraph.loadFromDb()
        return modelGraph
    }
    
    let database: Database
    var habits: [HabitModel]
    var habitTasks: [HabitTaskModel]
    var habitGroups: [HabitGroupModel]
    var habitGroupItems: [HabitGroupItemModel]
    var completions: [TaskCompletionModel]
    var settings: SettingsModel?
    
    var habitsUI: [HabitModel] {
        habits.filter { $0.showInUI && !$0.archived }.sorted { $0.sortOrder < $1.sortOrder }
    }
    var habitGroupsUI: [HabitGroupModel] {
        habitGroups.filter { $0.showInUI }.sorted { $0.sortOrder < $1.sortOrder }
    }
    var settingsUI: SettingsModel {
        settings ?? SettingsModel(self)
    }

    init(database: Database) {
        self.database = database
        self.habits = []
        self.habitTasks = []
        self.habitGroups = []
        self.habitGroupItems = []
        self.completions = []
        self.settings = nil
    }
    
    func loadFromDb() throws {
        try database.reader.read { db in
            _ = try HabitRecord.fetchAll(db).map { HabitModel(self, fromRecord: $0) }
            _ = try HabitTaskRecord.fetchAll(db).map { HabitTaskModel(self, fromRecord: $0) }
            _ = try HabitGroupRecord.fetchAll(db).map { HabitGroupModel(self, fromRecord: $0) }
            _ = try HabitGroupItemRecord.fetchAll(db).map { HabitGroupItemModel(self, fromRecord: $0) }
            _ = try TaskCompletionRecord.fetchAll(db).map { TaskCompletionModel(self, fromRecord: $0) }
            _ = try SettingsRecord.fetchAll(db).map { SettingsModel(self, fromRecord: $0) }
        }
    }
}
