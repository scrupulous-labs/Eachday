import Foundation
import GRDB

class HabitTaskRecord: Record, HabitTask {
    var id: UUID
    var habitId: UUID
    var description: String
    var sortOrder: SortOrder
    
    override class var databaseTableName: String { "habitTask" }
    
    enum Columns: String, ColumnExpression {
        case id
        case habitId
        case description
        case sortOrder
    }
    
    init(fromModel: HabitTaskModel) {
        self.id = fromModel.id
        self.habitId = fromModel.habitId
        self.description = fromModel.description
        self.sortOrder = fromModel.sortOrder
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.habitId = UUID(uuidString: row[Columns.habitId])!
        self.description = row[Columns.description]
        self.sortOrder = SortOrder(rank: row[Columns.sortOrder])
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.habitId] = habitId.uuidString.lowercased()
        container[Columns.description] = description
        container[Columns.sortOrder] = sortOrder.rank
    }
}
