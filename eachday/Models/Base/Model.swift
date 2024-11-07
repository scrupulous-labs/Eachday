import SwiftUI
import GRDB

enum ModelStatus {
    case changed   // model has changes to its db row
    case unChanged // model is same as in db
    case transient // model is not in db
}

@Observable
class Model<R: GRDB.Record>: ModelNode {
    var record: R?
    let rootStore: RootStore
    private var markedForDeletion: Bool

    init(_ rootStore: RootStore, fromRecord: R?, markForDeletion: Bool) {
        self.record = fromRecord
        self.rootStore = rootStore
        self.markedForDeletion = markForDeletion
        super.init()
        onCreate()
    }
    
    var showInUI: Bool { !markedForDeletion }
    var isModified: Bool { fatalError("subclass must override") }
    override var db: Database { return rootStore.database }
    override var children: [ModelNode] { fatalError("subclass must override") }
    override var isValid: Bool { fatalError("subclass must override") }
    override var isMarkedForDeletion: Bool { markedForDeletion }
    override var status: ModelStatus {
        if record == nil { return ModelStatus.transient }
        else if isModified { return ModelStatus.changed }
        else { return ModelStatus.unChanged }
    }
    
    func toRecord() -> R { fatalError("subclass must override") }
    func markForDeletion() {
        if status == ModelStatus.transient { graphResetToDb() }
        else { markedForDeletion = true }
    }
    override func insertToDb(db: GRDB.Database) throws { record = try toRecord().inserted(db) }
    override func updateToDb(db: GRDB.Database) throws { record = try toRecord().updateAndFetch(db) }
    override func deleteFromDb(db: GRDB.Database) throws { try record?.delete(db); record = nil }
    override func resetToDbRecord() { fatalError("subclass must override") }
    override func unmarkForDeletion() { markedForDeletion = false }
}

class ModelNode {
    var db: Database { fatalError("subclass must override") }
    var status: ModelStatus { fatalError("subclass must override") }
    var children: [ModelNode] { fatalError("subclass must override") }
    var isValid: Bool { fatalError("subclass must override") }
    var isMarkedForDeletion: Bool { fatalError("subclass must override") }
    var isGraphModified: Bool {
        (status == ModelStatus.changed && isValid) ||
        (status == ModelStatus.changed && isMarkedForDeletion) ||
        (status == ModelStatus.unChanged && isMarkedForDeletion) ||
        (status == ModelStatus.transient && isValid) ||
        (!children.isEmpty && children.contains { $0.isGraphModified })
    }
    
    init() { }
    
    func insertToDb(db: GRDB.Database) throws { fatalError("subclass must override") }
    func updateToDb(db: GRDB.Database) throws { fatalError("subclass must override") }
    func deleteFromDb(db: GRDB.Database) throws { fatalError("subclass must override") }
    func resetToDbRecord() { fatalError("subclass must override") }
    func unmarkForDeletion() { fatalError("subclass must override") }
    
    func onCreate() { }
    func onSave() { }
    func onUpdate() { }
    func onDelete() { }
    
    /*
     Reset model's graph to it's Database state
     */
    func graphResetToDb() {
        var queue: [ModelNode] = [self]
        while !queue.isEmpty {
            let model = queue.removeFirst()
            switch model.status {
            case ModelStatus.transient:
                model.onDelete()

            case ModelStatus.changed where model.isMarkedForDeletion:
                model.resetToDbRecord()
                model.unmarkForDeletion()

            case ModelStatus.changed:
                model.resetToDbRecord()
                
            case ModelStatus.unChanged where model.isMarkedForDeletion:
                model.unmarkForDeletion()
                
            default:
                break
            }
            
            queue.append(contentsOf: model.children)
        }
    }

    /*
     Save valid nodes of model's graph, delete those markedForDeletion and reset the rest
     to their initial state
     */
    func save() {
        var ops: [() -> Void] = []
        var dbOps: [(GRDB.Database) throws -> Void] = []
        var queue: [ModelNode] = [self]
        while !queue.isEmpty {
            let model = queue.removeFirst()
            switch model.status {
            case ModelStatus.transient where model.isMarkedForDeletion || !model.isValid:
                model.delete(ops: &ops, dbOps: &dbOps)
                continue
                
            case ModelStatus.transient:
                ops.append(model.onSave)
                dbOps.append(model.insertToDb)
                
            case ModelStatus.changed where model.isMarkedForDeletion:
                model.delete(ops: &ops, dbOps: &dbOps)
                continue
                
            case ModelStatus.changed where !model.isValid:
                model.resetToDbRecord()
                
            case ModelStatus.changed:
                ops.append(model.onUpdate)
                dbOps.append(model.updateToDb)
                
            case ModelStatus.unChanged where model.isMarkedForDeletion:
                model.delete(ops: &ops, dbOps: &dbOps)
                continue
                
            default:
                break
            }

            queue.append(contentsOf: model.children)
        }
        
        do {
            if !dbOps.isEmpty {
                try db.writer.write { for dbOp in dbOps { try dbOp($0) } }
            }
            if !ops.isEmpty {
                for op in ops { op() }
            }
        } catch let error {
            print(error)
        }
    }
    
    /*
     Delete model's graph from Database
     */
    private func delete(
        ops: inout [() -> Void],
        dbOps: inout [(GRDB.Database) throws -> Void]
    ) {
        var queue: [ModelNode] = [self]
        while !queue.isEmpty {
            let model = queue.removeFirst()
            switch model.status {
            case .transient:
                ops.append(model.onDelete)
                
            case .changed:
                ops.append(model.onDelete)
                dbOps.append(model.deleteFromDb)
                
            case .unChanged:
                ops.append(model.onDelete)
                dbOps.append(model.deleteFromDb)
            }
            
            queue.append(contentsOf: model.children)
        }
    }
}
