import Foundation
import GRDB

class HabitGroupItemRecord: Record, HabitGroupItem {
    var id: UUID
    var habitId: UUID
    var groupId: UUID
    
    override class var databaseTableName: String { "habitGroupItem" }
    
    enum Columns: String, ColumnExpression {
        case id
        case habitId
        case groupId
    }
    
    init(fromModel: HabitGroupItemModel) {
        self.id = fromModel.id
        self.habitId = fromModel.habitId
        self.groupId = fromModel.groupId
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.habitId = UUID(uuidString: row[Columns.habitId])!
        self.groupId = UUID(uuidString: row[Columns.groupId])!
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.habitId] = habitId.uuidString.lowercased()
        container[Columns.groupId] = groupId.uuidString.lowercased()
    }
}
