import Foundation

@Observable
class HabitStore: Store {
    var all: [HabitModel] = []
    
    var sorted: [HabitModel] {
        all.filter { $0.showInUI && !$0.archived }.sorted { $0.sortOrder < $1.sortOrder }
    }
    
    var archived: [HabitModel] {
        all.filter { $0.showInUI && $0.archived }.sorted { $0.sortOrder < $1.sortOrder }
    }
    
    var filtered: [HabitModel] {
        let filteredGroups = rootStore.habitGroups.filtered
        return sorted.filter { habit in
            let inFilteredGroups = habit.habitGroupItems.contains { filteredGroups.contains($0.groupId) }
            return filteredGroups.isEmpty || inFilteredGroups
        }
    }
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
    
    func moveHabit(offsets: IndexSet, to: Int) {
        var copy = sorted
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
}
