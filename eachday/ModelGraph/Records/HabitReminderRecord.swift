import Foundation
import GRDB

class HabitReminderRecord: Record, HabitReminder {
    var id: UUID
    var habitId: UUID
    var timeOfDay: Int
    var sunday: Bool
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool
    
    override class var databaseTableName: String { "habitReminder" }
    
    enum Columns: String, ColumnExpression {
        case id
        case habitId
        case timeOfDay
        case sunday
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }
    
    init(fromModel: HabitReminder) {
        self.id = fromModel.id
        self.habitId = fromModel.habitId
        self.timeOfDay = fromModel.timeOfDay
        self.sunday = fromModel.sunday
        self.monday = fromModel.monday
        self.tuesday = fromModel.tuesday
        self.wednesday = fromModel.wednesday
        self.thursday = fromModel.thursday
        self.friday = fromModel.friday
        self.saturday = fromModel.saturday
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.habitId = UUID(uuidString: row[Columns.habitId])!
        self.timeOfDay = row[Columns.timeOfDay]
        self.sunday = row[Columns.sunday]
        self.monday = row[Columns.monday]
        self.tuesday = row[Columns.tuesday]
        self.wednesday = row[Columns.wednesday]
        self.thursday = row[Columns.thursday]
        self.friday = row[Columns.friday]
        self.saturday = row[Columns.saturday]
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.habitId] = habitId.uuidString.lowercased()
        container[Columns.timeOfDay] = timeOfDay
        container[Columns.sunday] = sunday
        container[Columns.monday] = monday
        container[Columns.tuesday] = tuesday
        container[Columns.wednesday] = wednesday
        container[Columns.thursday] = thursday
        container[Columns.friday] = friday
        container[Columns.saturday] = saturday
    }
}
