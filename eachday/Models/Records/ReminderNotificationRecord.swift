import Foundation
import GRDB

class ReminderNotificationRecord: Record, ReminderNotification {
    var reminderId: UUID
    var sundayId: UUID
    var mondayId: UUID
    var tuesdayId: UUID
    var wednesdayId: UUID
    var thursdayId: UUID
    var fridayId: UUID
    var saturdayId: UUID
    
    override class var databaseTableName: String { "reminderNotification" }
    
    enum Columns: String, ColumnExpression {
        case reminderId
        case sundayId
        case mondayId
        case tuesdayId
        case wednesdayId
        case thursdayId
        case fridayId
        case saturdayId
    }
    
    init(fromModel: ReminderNotificationModel) {
        self.reminderId = fromModel.reminderId
        self.sundayId = fromModel.sundayId
        self.mondayId = fromModel.mondayId
        self.tuesdayId = fromModel.tuesdayId
        self.wednesdayId = fromModel.wednesdayId
        self.thursdayId = fromModel.thursdayId
        self.fridayId = fromModel.fridayId
        self.saturdayId = fromModel.saturdayId
        super.init()
    }
    
    required init(row: Row) throws {
        self.reminderId = UUID(uuidString: row[Columns.reminderId])!
        self.sundayId = UUID(uuidString: row[Columns.sundayId])!
        self.mondayId = UUID(uuidString: row[Columns.mondayId])!
        self.tuesdayId = UUID(uuidString: row[Columns.tuesdayId])!
        self.wednesdayId = UUID(uuidString: row[Columns.wednesdayId])!
        self.thursdayId = UUID(uuidString: row[Columns.thursdayId])!
        self.fridayId = UUID(uuidString: row[Columns.fridayId])!
        self.saturdayId = UUID(uuidString: row[Columns.saturdayId])!
        try super.init(row: row)
    }

    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.reminderId] = reminderId.uuidString.lowercased()
        container[Columns.sundayId] = sundayId.uuidString.lowercased()
        container[Columns.mondayId] = mondayId.uuidString.lowercased()
        container[Columns.tuesdayId] = tuesdayId.uuidString.lowercased()
        container[Columns.wednesdayId] = wednesdayId.uuidString.lowercased()
        container[Columns.thursdayId] = thursdayId.uuidString.lowercased()
        container[Columns.fridayId] = fridayId.uuidString.lowercased()
        container[Columns.saturdayId] = saturdayId.uuidString.lowercased()
    }
}
