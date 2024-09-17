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
    var habits: [HabitModel] = []
    var habitTasks: [HabitTaskModel] = []
    var habitGroups: [HabitGroupModel] = []
    var habitGroupItems: [HabitGroupItemModel] = []
    var completions: [TaskCompletionModel] = []
    
    var defaultHabitGroup: HabitGroupModel {
        habitGroups.first { $0.isDefault }!
    }
    var habitGroupsSorted: [HabitGroupModel] {
        habitGroups.filter { $0.showInUI }.sorted { $0.sortOrder < $1.sortOrder }
    }

    init(database: Database) {
        self.database = database
    }
    
    func loadFromDb() throws {
        try database.reader.read { db in
            _ = try HabitRecord.fetchAll(db).map { HabitModel(self, fromRecord: $0) }
            _ = try HabitTaskRecord.fetchAll(db).map { HabitTaskModel(self, fromRecord: $0) }
            _ = try HabitGroupRecord.fetchAll(db).map { HabitGroupModel(self, fromRecord: $0) }
            _ = try HabitGroupItemRecord.fetchAll(db).map { HabitGroupItemModel(self, fromRecord: $0)}
            _ = try TaskCompletionRecord.fetchAll(db).map { TaskCompletionModel(self, fromRecord: $0) }
        }
    }
}
