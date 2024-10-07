import Foundation

@Observable
class TaskCompletionModel: Model<TaskCompletionRecord>, TaskCompletion {
    var id: UUID
    var taskId: UUID
    var day: Day
    var habitTask: HabitTaskModel? = nil
    
    init(_ modelGraph: ModelGraph, fromRecord: TaskCompletionRecord) {
        self.id = fromRecord.id
        self.taskId = fromRecord.taskId
        self.day = fromRecord.day
        super.init(modelGraph, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ modelGraph: ModelGraph, taskId: UUID, day: Day, markForDeletion: Bool = false) {
        self.id = UUID()
        self.taskId = taskId
        self.day = day
        super.init(modelGraph, fromRecord: nil, markForDeletion: markForDeletion)
    }
    

//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }
    
    override func toRecord() -> TaskCompletionRecord { TaskCompletionRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() {
        habitTask = modelGraph.habitTasks.first { $0.id == taskId }
        
        habitTask?.completions.append(self)
        modelGraph.completions.append(self)
    }
    override func onDelete() {
        habitTask?.completions.removeAll { $0.id == id }
        modelGraph.completions.removeAll { $0.id == id }
    }
}
