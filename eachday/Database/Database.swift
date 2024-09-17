import Foundation
import GRDB

struct Database {    
    let writer: DatabaseWriter
    var reader: DatabaseReader { writer }
    
    init(_ dbWriter: DatabaseWriter) throws {
        self.writer = dbWriter
        try migrator.migrate(self.writer)
    }
}
