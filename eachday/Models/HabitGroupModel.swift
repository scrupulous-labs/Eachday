import Foundation

@Observable
class HabitGroupModel: Model<HabitGroupRecord>, HabitGroup {
    var id: UUID
    var name: String
    var sortOrder: SortOrder
    var habitGroupItems: [HabitGroupItemModel] = []
    
    var habitGroupItemsUI: [HabitGroupItemModel] {
        habitGroupItems.filter { $0.showInUI }
    }

    init(_ rootStore: RootStore, fromRecord: HabitGroupRecord) {
        self.id = fromRecord.id
        self.name = fromRecord.name
        self.sortOrder = fromRecord.sortOrder
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ rootStore: RootStore, sortOrder: SortOrder, markForDeletion: Bool = false) {
        self.id = UUID()
        self.name = ""
        self.sortOrder = sortOrder
        super.init(rootStore, fromRecord: nil, markForDeletion: markForDeletion)
    }


//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { habitGroupItems }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }

    override func toRecord() -> HabitGroupRecord { HabitGroupRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() {
        habitGroupItems = rootStore.habitGroupItems.all.filter { $0.groupId == id }
        
        habitGroupItems.forEach { $0.habitGroup = self }
        rootStore.habitGroups.all.append(self)
    }
    override func onDelete() {
        habitGroupItems.forEach { $0.habitGroup = nil }
        rootStore.habitGroups.all.removeAll { $0.id == id }
    }
}
