import Foundation

@Observable
class HabitTaskModel: Model<HabitTaskRecord>, HabitTask {    
    var id: UUID
    var habitId: UUID
    var description: String
    var sortOrder: SortOrder
    var habit: HabitModel? = nil
    var completions: [TaskCompletionModel] = []
    
    var completionsUI: [TaskCompletionModel] {
        completions.filter { $0.showInUI }
    }
    var completionsByDay: [Day: [TaskCompletionModel]] {
        completionsUI.reduce(into: [:]) { res, completion in
            res[completion.day] = (res[completion.day] ?? []) + [completion]
        }
    }

    init(_ rootStore: RootStore, fromRecord: HabitTaskRecord) {
        self.id = fromRecord.id
        self.habitId = fromRecord.habitId
        self.description = fromRecord.description
        self.sortOrder = fromRecord.sortOrder
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ rootStore: RootStore, habitId: UUID, sortOrder: SortOrder, markForDeletion: Bool = false) {
        self.id = UUID()
        self.habitId = habitId
        self.description = ""
        self.sortOrder = sortOrder
        super.init(rootStore, fromRecord: nil, markForDeletion: markForDeletion)
    }

//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { completions }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool {
        let isValid = validate()
        let isSingleTask = habit != nil && habit!.habitTasksUI.count == 1
        return isValid || isSingleTask
    }

    override func toRecord() -> HabitTaskRecord { HabitTaskRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() {
        habit = rootStore.habits.all.first { $0.id == habitId }
        completions = rootStore.taskCompletions.all.filter { $0.taskId == id }
        
        habit?.habitTasks.append(self)
        completions.forEach { $0.habitTask = self }
        rootStore.habitTasks.all.append(self)
    }
    override func onDelete() {
        habit?.habitTasks.removeAll { $0.id == id }
        completions.forEach { $0.habitTask = nil }
        rootStore.habitTasks.all.removeAll { $0.id == id }
    }
}
