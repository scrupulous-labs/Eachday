import Foundation

@Observable
class HabitGroupItemModel: Model<HabitGroupItemRecord>, HabitGroupItem {
    var id: UUID
    var habitId: UUID
    var groupId: UUID
    var habit: HabitModel? = nil
    var habitGroup: HabitGroupModel? = nil
    
    init(_ rootStore: RootStore, fromRecord: HabitGroupItemRecord) {
        self.id = fromRecord.id
        self.habitId = fromRecord.habitId
        self.groupId = fromRecord.groupId
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(
        _ rootStore: RootStore,
        habitId: UUID, groupId: UUID, markForDeletion: Bool = false
    ) {
        self.id = UUID.init()
        self.habitId = habitId
        self.groupId = groupId
        super.init(rootStore, fromRecord: nil, markForDeletion: markForDeletion)
    }


//
// MARK - OVERRIDES
//
    override var showInUI: Bool { super.showInUI && habit != nil && !habit!.archived }
    override var children: [ModelNode] { [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }

    override func toRecord() -> HabitGroupItemRecord { HabitGroupItemRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() {
        habit = rootStore.habits.all.first { $0.id == habitId }
        habitGroup = rootStore.habitGroups.all.first { $0.id == groupId }
        
        habit?.habitGroupItems.append(self)
        habitGroup?.habitGroupItems.append(self)
        rootStore.habitGroupItems.all.append(self)
    }
    override func onDelete() {
        habit?.habitGroupItems.removeAll { $0.id == id }
        habitGroup?.habitGroupItems.removeAll { $0.id == id }
        rootStore.habitGroupItems.all.removeAll { $0.id == id}
    }
}
