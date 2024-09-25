import Foundation

@Observable
class HabitGroupItemModel: Model<HabitGroupItemRecord>, HabitGroupItem {
    var id: UUID
    var habitId: UUID
    var groupId: UUID
    var habit: HabitModel? = nil
    var habitGroup: HabitGroupModel? = nil
    
    init(_ modelGraph: ModelGraph, fromRecord: HabitGroupItemRecord) {
        self.id = fromRecord.id
        self.habitId = fromRecord.habitId
        self.groupId = fromRecord.groupId
        super.init(modelGraph, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(
        _ modelGraph: ModelGraph,
        habitId: UUID, groupId: UUID, markForDeletion: Bool = false
    ) {
        self.id = UUID.init()
        self.habitId = habitId
        self.groupId = groupId
        super.init(modelGraph, fromRecord: nil, markForDeletion: markForDeletion)
    }

    
//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }

    override func toRecord() -> HabitGroupItemRecord { HabitGroupItemRecord(fromModel: self) }
    override func addToGraph() {
        habit = modelGraph.habits.first { $0.id == habitId }
        habitGroup = modelGraph.habitGroups.first { $0.id == groupId }
        
        habit?.habitGroupItems.append(self)
        habitGroup?.habitGroupItems.append(self)
        modelGraph.habitGroupItems.append(self)
    }
    override func removeFromGraph() {
        habit?.habitGroupItems.removeAll { $0.id == id }
        habitGroup?.habitGroupItems.removeAll { $0.id == id }
        modelGraph.habitGroupItems.removeAll { $0.id == id}
    }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
}
