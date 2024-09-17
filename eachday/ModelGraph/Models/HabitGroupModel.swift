import Foundation

@Observable
class HabitGroupModel: Model<HabitGroupRecord>, HabitGroup {
    var id: UUID
    var name: String
    var sortOrder: SortOrder
    var isDefault: Bool
    var habitGroupItems: [HabitGroupItemModel] = []
    var habitGroupItemsSorted: [HabitGroupItemModel] {
        habitGroupItems.filter { $0.showInUI }.sorted { $0.sortOrder < $1.sortOrder }
    }

    init(_ modelGraph: ModelGraph, fromRecord: HabitGroupRecord) {
        self.id = fromRecord.id
        self.name = fromRecord.name
        self.sortOrder = fromRecord.sortOrder
        self.isDefault = fromRecord.isDefault
        super.init(modelGraph, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ modelGraph: ModelGraph, sortOrder: SortOrder, markForDeletion: Bool = false) {
        self.id = UUID()
        self.name = ""
        self.sortOrder = sortOrder
        self.isDefault = false
        super.init(modelGraph, fromRecord: nil, markForDeletion: markForDeletion)
    }
    
    
//
// MARK - FOR UI
//
    func moveItem(offsets: IndexSet, to: Int) {
        var copy = self.habitGroupItemsSorted
        let count = copy.count
        let from = Array(offsets).first
        
        if from != nil {
            copy.move(fromOffsets: offsets, toOffset: to)
            // inserted at array start
            if to == 0 && count >= 2 {
                copy[0].sortOrder = copy[1].sortOrder.prev()
                copy[0].save()
            // inserted at array end
            } else if to == count && count >= 2 {
                copy[count - 1].sortOrder = copy[count - 2].sortOrder.next()
                copy[count - 1].save()
            // moved from bottom to top and inserted in between array
            } else if from! > to && 0 < to && to < count - 1 && count >= 3  {
                copy[to].sortOrder = SortOrder.middle(
                    r1: copy[to - 1].sortOrder,
                    r2: copy[to + 1].sortOrder
                )
                copy[to].save()
            // moved from top to bottom and inserted in between array
            } else if from! < to && 0 < to - 1 && to - 1 < count - 1 && count >= 3 {
                copy[to - 1].sortOrder = SortOrder.middle(
                    r1: copy[to - 2].sortOrder,
                    r2: copy[to].sortOrder
                )
                copy[to - 1].save()
            }
        }
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
