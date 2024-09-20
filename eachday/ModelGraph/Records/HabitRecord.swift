import Foundation
import GRDB

class HabitRecord: Record, Habit {
    var id: UUID
    var name: String
    var icon: HabitIcon
    var color: HabitColor
    var archived: Bool
    var frequency: Frequency
    var sortOrder: SortOrder
    
    override class var databaseTableName: String { "habit" }
    
    enum Columns: String, ColumnExpression {
        case id
        case name
        case icon
        case color
        case archived
        case frequency
        case sortOrder
    }
    
    init(fromModel: Habit) {
        self.id = fromModel.id
        self.name = fromModel.name
        self.icon = fromModel.icon
        self.color = fromModel.color
        self.archived = fromModel.archived
        self.frequency = fromModel.frequency
        self.sortOrder = fromModel.sortOrder
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.name = row[Columns.name]
        self.icon = HabitIcon(rawValue: row[Columns.icon]) ?? HabitIcon.briefcase
        self.color = HabitColor(rawValue: row[Columns.color]) ?? HabitColor.blue
        self.archived = row[Columns.archived]
        self.frequency = Frequency.fromJson(json: row[Columns.frequency]) ?? Frequency.daily(times: 1)
        self.sortOrder = SortOrder(rank: row[Columns.sortOrder])
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.name] = name
        container[Columns.icon] = icon.rawValue
        container[Columns.color] = color.rawValue
        container[Columns.archived] = archived
        container[Columns.frequency] = frequency.toJson()
        container[Columns.sortOrder] = sortOrder.rank
    }
}
