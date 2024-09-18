import Foundation

@Observable
class HabitGroupModel: Model<HabitGroupRecord>, HabitGroup {
    var id: UUID
    var name: String
    var sortOrder: SortOrder
    var habitGroupItems: [HabitGroupItemModel] = []

    init(_ modelGraph: ModelGraph, fromRecord: HabitGroupRecord) {
        self.id = fromRecord.id
        self.name = fromRecord.name
        self.sortOrder = fromRecord.sortOrder
        super.init(modelGraph, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ modelGraph: ModelGraph, sortOrder: SortOrder, markForDeletion: Bool = false) {
        self.id = UUID()
        self.name = ""
        self.sortOrder = sortOrder
        super.init(modelGraph, fromRecord: nil, markForDeletion: markForDeletion)
    }

//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { habitGroupItems }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }

    override func toRecord() -> HabitGroupRecord { HabitGroupRecord(fromModel: self) }
    override func addToGraph() {
        habitGroupItems = modelGraph.habitGroupItems.filter { $0.groupId == id }
        
        habitGroupItems.forEach { $0.habitGroup = self }
        modelGraph.habitGroups.append(self)
    }
    override func removeFromGraph() {
        habitGroupItems.forEach { $0.habitGroup = nil }
        modelGraph.habitGroups.removeAll { $0.id == id }
    }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
}
