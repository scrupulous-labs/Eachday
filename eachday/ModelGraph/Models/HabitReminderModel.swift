import Foundation

@Observable
class HabitReminderModel: Model<HabitReminderRecord>, HabitReminder {
    var id: UUID
    var habitId: UUID
    var dayOfWeek: DayOfWeek
    var timeOfDay: Int
    var habit: HabitModel? = nil
    
    init(_ modelGraph: ModelGraph, fromRecord: HabitReminderRecord) {
        self.id = fromRecord.id
        self.habitId = fromRecord.habitId
        self.dayOfWeek = fromRecord.dayOfWeek
        self.timeOfDay = fromRecord.timeOfDay
        super.init(modelGraph, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(
        _ modelGraph: ModelGraph, habitId: UUID,
        dayOfWeek: DayOfWeek, timeOfDay: Int, markForDeletion: Bool
    ) {
        self.id = UUID()
        self.habitId = habitId
        self.dayOfWeek = dayOfWeek
        self.timeOfDay = timeOfDay
        super.init(modelGraph, fromRecord: nil, markForDeletion: markForDeletion)
    }
    
//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }
    
    override func toRecord() -> HabitReminderRecord { HabitReminderRecord(fromModel: self) }
    override func addToGraph() {
        habit = modelGraph.habits.first { $0.id == habitId }
        
        habit?.habitReminders.append(self)
        modelGraph.habitReminders.append(self)
    }
    override func removeFromGraph() {
        habit?.habitReminders.removeAll { $0.id == id }
        modelGraph.habitReminders.removeAll { $0.id == id }
    }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
}
