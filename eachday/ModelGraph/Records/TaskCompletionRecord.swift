import Foundation
import GRDB

class TaskCompletionRecord: Record, TaskCompletion {
    var id: UUID
    var taskId: UUID
    var day: Day
    
    override class var databaseTableName: String { "taskCompletion" }
    
    enum Columns: String, ColumnExpression {
        case id
        case habitId
        case taskId
        case day
    }
    
    init(fromModel: TaskCompletionModel) {
        self.id = fromModel.id
        self.taskId = fromModel.taskId
        self.day = fromModel.day
        super.init()
    }
    
    required init(row: Row) throws {
        self.id = UUID(uuidString: row[Columns.id])!
        self.taskId = UUID(uuidString: row[Columns.taskId])!
        self.day = Day.fromDate(row[Columns.day])
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = id.uuidString.lowercased()
        container[Columns.taskId] = taskId.uuidString.lowercased()
        container[Columns.day] = day.toDate()
    }
}
