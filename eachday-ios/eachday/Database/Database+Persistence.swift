import Foundation
import GRDB
import os.log

extension Database {
    static func makeDb() -> Database {
        do {
            let fileManager = FileManager.default
            let appSupportURL = try fileManager.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let directoryURL = appSupportURL.appendingPathComponent("Database", isDirectory: true)
//            try fileManager.removeItem(at: directoryURL)
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
            let dbPool = try DatabasePool(
                path: directoryURL.appendingPathComponent("doit.sqlite").path,
                configuration: Database.makeConfiguration()
            )
            let database = try Database(dbPool)
            return database
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    private static func makeConfiguration() -> Configuration {
        var config = Configuration()
        let sqlLogger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "SQL")
        
        #if DEBUG
        config.publicStatementArguments = true
        config.prepareDatabase { db in
            db.trace { os_log("%{public}@", log: sqlLogger, type: .debug, String(describing: $0)) }
        }
        #endif
        
        return config
    }
}
