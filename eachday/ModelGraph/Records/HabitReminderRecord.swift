import Foundation
import GRDB

class HabitReminderRecord: Record, HabitReminder {
    var id: UUID
    var habitId: UUID
    var dayOfWeek: DayOfWeek
    var timeOfDay: Int
    
    override class var databaseTableName: String { "habitReminder" }
    
    enum Columns: String, ColumnExpression {
        case id
        case habitId
        case dayOfWeek
        case timeOfDay
    }
    
    init(fromModel: HabitReminderModel) {
        self.id = fromModel.id
        self.habitId = fromModel.habitId
        self.dayOfWeek = fromModel.dayOfWeek
        self.timeOfDay = fromModel.timeOfDay
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.habitId = UUID(uuidString: row[Columns.habitId])!
        self.dayOfWeek = DayOfWeek(rawValue: row[Columns.dayOfWeek])!
        self.timeOfDay = row[Columns.timeOfDay]
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.habitId] = habitId.uuidString.lowercased()
        container[Columns.dayOfWeek] = dayOfWeek.rawValue
        container[Columns.timeOfDay] = timeOfDay
    }
}
