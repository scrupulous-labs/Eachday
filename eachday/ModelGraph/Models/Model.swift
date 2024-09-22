import SwiftUI
import GRDB

enum ModelStatus {
    case changed   //model has changes to its db row
    case unChanged //model is same as in db
    case transient //model is not in db
}

@Observable
class Model<R: GRDB.Record>: ModelNode {
    var record: R?
    var markedForDeletion: Bool
    let modelGraph: ModelGraph

    init(_ modelGraph: ModelGraph, fromRecord: R?, markForDeletion: Bool) {
        self.record = fromRecord
        self.markedForDeletion = markForDeletion
        self.modelGraph = modelGraph
        super.init()
        addToGraph()
    }
    
    var showInUI: Bool { !markedForDeletion }
    var isModified: Bool { fatalError("subclass must override") }
    override var db: Database { return modelGraph.database }
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
    override func addToGraph() { fatalError("subclass must override") }
    override func removeFromGraph() { fatalError("subclass must override") }
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
    func addToGraph() { fatalError("subclass must override") }
    func removeFromGraph() { fatalError("subclass must override") }
    func resetToDbRecord() { fatalError("subclass must override") }
    func unmarkForDeletion() { fatalError("subclass must override") }
    
    func preSave() { }
    func preUpdate() { }
    func preDelete() { }
    
    /*
     Reset model's graph to it's Database state
     */
    func graphResetToDb() {
        var queue: [ModelNode] = [self]
        while !queue.isEmpty {
            let model = queue.removeFirst()
            switch model.status {
            case ModelStatus.transient:
                model.removeFromGraph()

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
     unmark for deletion all nodes in graph
     */
    func graphUmarkForDeletion() {
        var queue: [ModelNode] = [self]
        while !queue.isEmpty {
            let model = queue.removeFirst()
            model.unmarkForDeletion()
            queue.append(contentsOf: model.children)
        }
    }

    /*
     Save valid nodes of model's graph, delete those markedForDeletion and reset the rest
     to their initial state
     */
    func save() {
        var queue: [ModelNode] = [self]
        var dbOps: [(GRDB.Database) throws -> Void] = []
        while !queue.isEmpty {
            let model = queue.removeFirst()
            switch model.status {
            case ModelStatus.transient where model.isMarkedForDeletion || !model.isValid:
                model.delete(dbOps: &dbOps)
                
            case ModelStatus.transient:
                model.preSave()
                dbOps.append(model.insertToDb)
                
            case ModelStatus.changed where model.isMarkedForDeletion:
                model.delete(dbOps: &dbOps)
                
            case ModelStatus.changed where !model.isValid:
                model.resetToDbRecord()
                
            case ModelStatus.changed:
                model.preUpdate()
                dbOps.append(model.updateToDb)
                
            case ModelStatus.unChanged where model.isMarkedForDeletion:
                model.delete(dbOps: &dbOps)
                
            default:
                break
            }

            queue.append(contentsOf: model.children)
        }
        
        do {
            if !dbOps.isEmpty {
                try db.writer.write { for dbOp in dbOps { try dbOp($0) } }
            }
        } catch let error {
            print(error)
        }
    }
    
    /*
     Delete model's graph from Database
     */
    private func delete(dbOps: inout [(GRDB.Database) throws -> Void]) {
        var queue: [ModelNode] = [self]
        while !queue.isEmpty {
            let model = queue.removeFirst()
            switch model.status {
            case .transient:
                model.removeFromGraph()
                
            case .changed:
                model.preDelete()
                model.removeFromGraph()
                dbOps.append(model.deleteFromDb)
                
            case .unChanged:
                model.preDelete()
                model.removeFromGraph()
                dbOps.append(model.deleteFromDb)
            }
            
            queue.append(contentsOf: model.children)
        }
    }
}
