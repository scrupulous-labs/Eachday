import Foundation
import SwiftUI

@Observable
class HabitModel: Model<HabitRecord>, Habit {
    var id: UUID
    var name: String
    var icon: HabitIcon
    var color: HabitColor
    var archived: Bool
    var frequency: Frequency
    var sortOrder: SortOrder
    var habitTasks: [HabitTaskModel] = []
    var habitReminders: [HabitReminderModel] = []
    var habitGroupItems: [HabitGroupItemModel] = []
    var completionsByDay: [Day: [TaskCompletionModel]] = [:]
    
    var habitTasksUI: [HabitTaskModel] {
        habitTasks.filter { $0.showInUI }.sorted { $0.sortOrder < $1.sortOrder }
    }
    var habitRemindersUI: [HabitReminderModel] {
        habitReminders.filter { $0.showInUI }.sorted { $0.timeOfDay < $1.timeOfDay }
    }
    var habitGroupItemsUI: [HabitGroupItemModel] {
        habitGroupItems.filter { $0.showInUI }
    }
    
    init(_ rootStore: RootStore, fromRecord: HabitRecord) {
        self.id = fromRecord.id
        self.name = fromRecord.name
        self.icon = fromRecord.icon
        self.color = fromRecord.color
        self.archived = fromRecord.archived
        self.frequency = fromRecord.frequency
        self.sortOrder = fromRecord.sortOrder
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
        deriveCompletionsByDay()
    }
    
    init(_ rootStore: RootStore, sortOrder: SortOrder, markForDeletion: Bool = false) {
        self.id = UUID()
        self.name = ""
        self.icon = HabitIcon.briefcase
        self.color = HabitColor.blue
        self.archived = false
        self.frequency = Frequency.daily(times: 1)
        self.sortOrder = sortOrder
        super.init(rootStore, fromRecord: nil, markForDeletion: markForDeletion)
        deriveCompletionsByDay()
    }
    
    func deriveCompletionsByDay() {
        self.completionsByDay =
            withObservationTracking {
                habitTasksUI.reduce(into: [:]) { res, habitTask in
                    habitTask.completionsByDay.forEach { (day, completions) in
                        res[day] = (res[day] ?? []) + completions
                    }
                }
            } onChange: {
                DispatchQueue.main.async { [self] in deriveCompletionsByDay() }
            }
    }

//
// MARK - FOR UI
//
    func isCompleted(day: Day) -> Bool {
        dayStatus(day: day) == HabitDayStatus.completed
    }
    
    func repetitionsToGo(day: Day) -> Int {
        frequency.repetitionsPerDay - repetitionsCompleted(day: day)
    }
    
    func repetitionsCompleted(day: Day) -> Int {
        if habitTasksUI.isEmpty { return 0 }
        let totalTasks = habitTasksUI.count
        let totalCompletions = (completionsByDay[day] ?? []).count
        return totalCompletions / totalTasks
    }
    
    func repetitionCompletedTasks(day: Day) -> [HabitTaskModel] {
        if habitTasksUI.isEmpty { return [] }
        let totalTasks = habitTasksUI.count
        let totalCompletions = (completionsByDay[day] ?? []).count
        return Array(habitTasksUI[..<(totalCompletions % totalTasks)])
    }
    
    func nextTaskToComplete(day: Day) -> HabitTaskModel? {
        if habitTasksUI.isEmpty { return nil }
        let totalTasks = habitTasksUI.count
        let totalCompletions = (completionsByDay[day] ?? []).count
        let nextTaskIndex = totalCompletions % totalTasks
        return !isCompleted(day: day) ? habitTasksUI[nextTaskIndex] : nil
    }

    func markNextTask(day: Day) {
        let nextTask = nextTaskToComplete(day: day)
        if nextTask != nil {
            _ = TaskCompletionModel(rootStore, taskId: nextTask!.id, day: day)
        }
    }
    
    func markNextRepetition(day: Day, repetition: Int? = nil) {
        let nextTask = nextTaskToComplete(day: day)
        let repetition = repetition ?? repetitionsCompleted(day: day)
        if nextTask != nil && repetitionsCompleted(day: day) <= repetition {
            _ = TaskCompletionModel(rootStore, taskId: nextTask!.id, day: day)
            DispatchQueue.main.async { [self] in
                markNextRepetition(day: day, repetition: repetition)
            }
        }
    }
    
    func unmarkDay(day: Day) {
        if isCompleted(day: day) {
            habitTasks.forEach { task in
                task.completions.forEach { completion in
                    if completion.day == day { completion.markForDeletion() }
                }
            }
        }
    }
    
    func dayCalendarColor(day: Day) -> Color {
        switch dayStatus(day: day) {
            case .completed:
                return color.shade5
            case .partiallyCompleted(let value) where value > 0.75:
                return color.shade4
            case .partiallyCompleted(let value) where value > 0.5:
                return color.shade3
            case .partiallyCompleted(let value) where value > 0.25:
                return color.shade2
            case .partiallyCompleted(_):
                return color.shade1
            default:
                return .white.opacity(0)
        }
    }
    
    private func dayStatus(day: Day) -> HabitDayStatus {
        let completions = completionsByDay[day] ?? []
        let repetitionsDone = repetitionsCompleted(day: day)
        let repetitionsTotal = frequency.repetitionsPerDay
        
        if completions.isEmpty || repetitionsDone == 0 {
            return HabitDayStatus.notCompleted
        } else if repetitionsDone < repetitionsTotal {
            let value = Double(repetitionsDone) / Double(repetitionsTotal)
            return HabitDayStatus.partiallyCompleted(value: value)
        } else {
            return HabitDayStatus.completed
        }
    }
    
    @discardableResult
    func addEmptyTask() -> HabitTaskModel {
        let lastTask = habitTasksUI.last
        let sortOrder = lastTask == nil ? SortOrder.new() : lastTask!.sortOrder.next()
        let task = HabitTaskModel(
            rootStore, habitId: id,
            sortOrder: sortOrder, markForDeletion: true
        )
        
        completionsByDay.forEach { (day, _) in
            let repetitionsDone = repetitionsCompleted(day: day)
            for _ in 0..<repetitionsDone {
                _ = TaskCompletionModel(
                    rootStore, taskId: task.id,
                    day: day, markForDeletion: true
                )
            }
        }
        task.graphUmarkForDeletion()
        return task
    }

    func moveTask(offsets: IndexSet, to: Int) {
        var copy = self.habitTasksUI
        let count = copy.count
        let from = Array(offsets).first
        
        if from != nil {
            copy.move(fromOffsets: offsets, toOffset: to)
            // inserted at array start
            if to == 0 && count >= 2 {
                copy[0].sortOrder = copy[1].sortOrder.prev()
            // inserted at array end
            } else if to == count && count >= 2 {
                copy[count - 1].sortOrder = copy[count - 2].sortOrder.next()
            // moved from bottom to top and inserted in between array
            } else if from! > to && 0 < to && to < count - 1 && count >= 3  {
                copy[to].sortOrder = SortOrder.middle(
                    r1: copy[to - 1].sortOrder,
                    r2: copy[to + 1].sortOrder
                )
            // moved from top to bottom and inserted in between array
            } else if from! < to && 0 < to - 1 && to - 1 < count - 1 && count >= 3 {
                copy[to - 1].sortOrder = SortOrder.middle(
                    r1: copy[to - 2].sortOrder,
                    r2: copy[to].sortOrder
                )
            }
        }
    }
    
    func archive() {
        archived = true; save()
        habitReminders.forEach { reminder in
            reminder.cancelAllNotifications()
        }
    }

    func unarchive() {
        archived = false; save()
        habitReminders.forEach { reminder in
            Task { await reminder.registerNotifications() }
        }
    }

//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { habitTasks + habitGroupItems + habitReminders }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }

    override func toRecord() -> HabitRecord { HabitRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() {
        habitTasks = rootStore.habitTasks.all.filter { $0.habitId == id }
        habitGroupItems = rootStore.habitGroupItems.all.filter { $0.habitId == id }
        habitReminders = rootStore.habitReminders.all.filter { $0.habitId == id }
        
        habitTasks.forEach { $0.habit = self }
        habitGroupItems.forEach { $0.habit = self }
        habitReminders.forEach { $0.habit = self }
        rootStore.habits.all.append(self)
    }
    override func onDelete() {
        habitTasks.forEach { $0.habit = nil }
        habitGroupItems.forEach { $0.habit = nil }
        habitReminders.forEach { $0.habit = nil }
        rootStore.habits.all.removeAll { $0.id == id }
    }
}
