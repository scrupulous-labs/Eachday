import Foundation
import GRDB

class HabitGroupRecord: Record, HabitGroup {
    var id: UUID
    var name: String
    var sortOrder: SortOrder
    
    override class var databaseTableName: String { "habitGroup" }
    
    enum Columns: String, ColumnExpression {
        case id
        case name
        case sortOrder
    }
    
    init(fromModel: HabitGroupModel) {
        self.id = fromModel.id
        self.name = fromModel.name
        self.sortOrder = fromModel.sortOrder
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.name = row[Columns.name]
        self.sortOrder = SortOrder(rank: row[Columns.sortOrder])
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.name] = name
        container[Columns.sortOrder] = sortOrder.rank
    }
}
