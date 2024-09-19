import Foundation
import GRDB

class SettingsRecord: Record, Settings {
    var id: Int = 1
    var savedTheme: Theme?
    var savedStartOfWeek: DayOfWeek?
    
    override class var databaseTableName: String { "settings" }
    
    enum Columns: String, ColumnExpression {
        case id
        case savedTheme
        case savedStartOfWeek
    }
    
    init(fromModel: Settings) {
        self.savedTheme = fromModel.savedTheme
        self.savedStartOfWeek = fromModel.savedStartOfWeek
        super.init()
    }
    
    required init(row: Row) throws {
        self.savedTheme = row[Columns.savedTheme] != nil 
            ? Theme(rawValue: row[Columns.savedTheme]) 
            : nil
        self.savedStartOfWeek = row[Columns.savedStartOfWeek] != nil
            ? DayOfWeek(rawValue: row[Columns.savedStartOfWeek])
            : nil
        try super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.id] = 1
        container[Columns.savedTheme] = savedTheme?.rawValue
        container[Columns.savedStartOfWeek] = savedStartOfWeek?.rawValue
    }
}
