import Foundation

@Observable
class TaskCompletionModel: Model<TaskCompletionRecord>, TaskCompletion {
    var id: UUID
    var taskId: UUID
    var day: Day
    var habitTask: HabitTaskModel? = nil
    
    init(_ rootStore: RootStore, fromRecord: TaskCompletionRecord) {
        self.id = fromRecord.id
        self.taskId = fromRecord.taskId
        self.day = fromRecord.day
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ rootStore: RootStore, taskId: UUID, day: Day, markForDeletion: Bool = false) {
        self.id = UUID()
        self.taskId = taskId
        self.day = day
        super.init(rootStore, fromRecord: nil, markForDeletion: markForDeletion)
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
        habitTask = rootStore.habitTasks.all.first { $0.id == taskId }
        
        habitTask?.completions.append(self)
        rootStore.taskCompletions.all.append(self)
    }
    override func onDelete() {
        habitTask?.completions.removeAll { $0.id == id }
        rootStore.taskCompletions.all.removeAll { $0.id == id }
    }
}
