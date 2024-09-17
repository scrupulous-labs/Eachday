import Foundation
import GRDB

extension Database {
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("V1") {db in
            try db.create(table: "habit") { t in
                t.column("id", .text).primaryKey()
                t.column("name", .text).notNull()
                t.column("icon", .text).notNull()
                t.column("color", .text).notNull()
                t.column("archived", .boolean).notNull()
                t.column("frequency", .text).notNull()
            }
            
            try db.create(table: "habitTask") { t in
                t.column("id", .text).primaryKey()
                t.column("habitId", .text).references("habit", column: "id", onDelete: .cascade).notNull()
                t.column("description", .text).notNull()
                t.column("sortOrder", .real).notNull()
            }

            try db.create(table: "taskCompletion") { t in
                t.column("id", .text).primaryKey()
                t.column("taskId", .text).references("habitTask", column: "id", onDelete: .cascade).notNull()
                t.column("day", .date).notNull()
            }
            
            try db.create(table: "habitGroup") { t in
                t.column("id", .text).primaryKey()
                t.column("name", .text).notNull()
                t.column("sortOrder", .real).notNull()
                t.column("isDefault", .boolean).notNull()
            }
            
            try db.create(table: "habitGroupItem") { t in
                t.column("id", .text).primaryKey()
                t.column("habitId", .text).references("habit", column: "id", onDelete: .cascade).notNull()
                t.column("groupId", .text).references("habitGroup", column: "id", onDelete: .cascade).notNull()
                t.column("sortOrder", .real).notNull()
                t.uniqueKey(["habitId", "groupId"], onConflict: .replace)
            }
            
            try db.execute(
                sql: "INSERT INTO habitGroup (id, name, sortOrder, isDefault) VALUES (?, ?, ?, ?)",
                arguments: [UUID().uuidString.lowercased(), "All", 0.0, true]
            )
        }
        
        return migrator
    }
}
