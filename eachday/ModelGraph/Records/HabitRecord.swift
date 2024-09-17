import Foundation
import GRDB

class HabitRecord: Record, Habit {
    var id: UUID
    var name: String
    var icon: HabitIcon
    var color: HabitColor
    var archived: Bool
    var frequency: Frequency
    
    override class var databaseTableName: String { "habit" }
    
    enum Columns: String, ColumnExpression {
        case id
        case name
        case icon
        case color
        case archived
        case frequency
    }
    
    init(fromModel: Habit) {
        self.id = fromModel.id
        self.name = fromModel.name
        self.icon = fromModel.icon
        self.color = fromModel.color
        self.archived = fromModel.archived
        self.frequency = fromModel.frequency
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.name = row[Columns.name]
        self.icon = HabitIcon(rawValue: row[Columns.icon])!
        self.color = HabitColor(rawValue: row[Columns.color])!
        self.archived = row[Columns.archived]
        self.frequency = Frequency.fromJson(json: row[Columns.frequency])!
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.name] = name
        container[Columns.icon] = icon.rawValue
        container[Columns.color] = color.rawValue
        container[Columns.archived] = archived
        container[Columns.frequency] = frequency.toJson()
    }
}
