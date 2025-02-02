import SwiftUI

struct EditHabitView: View {
    @Bindable var habit: HabitModel
    @Binding var canCancel: Bool
    @Binding var attemptedToCancel: Bool
    @Bindable var ui: EditHabitViewModel = EditHabitViewModel.instance
    
    @Environment(\.dismiss) var dismiss
    @Environment(RootStore.self) var rootStore
    @FocusState private var focusedField: EditHabitFormField?

    var body: some View {
        NavigationStack(path: $ui.navigationPath) {
            Form {
                EditHabitSectionHabit(
                    habit: habit,
                    focusedField: $focusedField,
                    onFieldChange: onFieldChange,
                    onIconChange: ui.openSelectIconScreen
                )
                EditHabitSectionChecklist(
                    habit: habit,
                    focusedField: $focusedField,
                    onFieldChange: onFieldChange
                )
                EditHabitSectionGoal(
                    habit: habit,
                    focusedField: $focusedField,
                    onChangeFrequency: ui.openSelectFrequencySheet,
                    onChangeReminders: { ui.openSetRemindersScreen(rootStore, habit: habit) },
                    onChangeGroup: { ui.openSelectGroupScreen(rootStore) }
                )
                EditHabitSectionColor(
                    habit: habit,
                    onFieldChange: onFieldChange
                )
            }
            .padding(.top, 0)
            .navigationTitle(habit.isMarkedForDeletion ? "New Habit" : "Edit Habit")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(hex: "#1C1C1E"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { cancel() } label: { Text("Cancel").fontWeight(.medium) }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { done() } label: { Text("Done").fontWeight(.medium) }
                }
            }
            .sheet(item: $ui.activeSheet) { item in
                switch item {
                case EditHabitSheet.selectFrequencySheet:
                    EditHabitSelectFrequency(habit: habit, onFieldChange: onFieldChange)
                        .presentationDetents([.fraction(0.65)])
                        .presentationDragIndicator(.visible)
                }
            }
            .navigationDestination(for: EditHabitScreen.self) { destination in
                switch destination {
                case EditHabitScreen.setRemindersScreen:
                    EditHabitSetReminders(
                        habit: habit,
                        onFieldChange: onFieldChange
                    )
                case EditHabitScreen.selectGroupScreen(let newGroup):
                    EditHabitSelectGroup(
                        habit: habit,
                        newGroup: newGroup,
                        onFieldChange: onFieldChange,
                        onSaveNewGroup: {
                            newGroup.addHabit(habit: habit)
                            newGroup.unmarkForDeletion(); newGroup.save();
                            onFieldChange()
                            ui.navigationPath.removeLast()
                            ui.openSelectGroupScreen(rootStore)
                        }
                    )
                case EditHabitScreen.selectIconScreen:
                    EditHabitSelectIcon(
                        habit: habit,
                        onFieldChange: onFieldChange
                    )
                }
            }
            .confirmationDialog(
                "Are you sure you want to discard this new habit?",
                isPresented: $attemptedToCancel,
                titleVisibility: .visible
            ) {
                Button("Discard Changes", role: .destructive) { discardChanges() }
                Button("Keep Editing", role: .cancel) { }
            }
            .onAppear {
                if habit.isMarkedForDeletion {
                    focusedField = EditHabitFormField.habitName
                }
            }
        }
    }
    
    func done() {
        if habit.isMarkedForDeletion { habit.unmarkForDeletion() }
        habit.save(); dismiss()
    }
    func cancel() {
        if canCancel { discardChanges() }
        else { attemptedToCancel = true }
    }
    func discardChanges() { habit.graphResetToDb(); dismiss() }
    func onFieldChange() { canCancel = !habit.isGraphModified }
}

@Observable
class EditHabitViewModel {
    static var instance: EditHabitViewModel = EditHabitViewModel()
    
    var activeSheet: EditHabitSheet? = nil
    var navigationPath: NavigationPath = NavigationPath()
    
    func openSelectFrequencySheet() {
        activeSheet = EditHabitSheet.selectFrequencySheet
    }
    
    func openSetRemindersScreen(_ rootStore: RootStore, habit: HabitModel) {
        navigationPath.append(EditHabitScreen.setRemindersScreen)
    }
    
    func openSelectGroupScreen(_ rootStore: RootStore) {
        let lastGroup = rootStore.habitGroups.sorted.last
        let sortOrder = lastGroup?.sortOrder.next() ?? SortOrder.new()
        navigationPath.append(EditHabitScreen.selectGroupScreen(
            HabitGroupModel(rootStore, sortOrder: sortOrder, markForDeletion: true)
        ))
    }
    
    func openSelectIconScreen() {
        navigationPath.append(EditHabitScreen.selectIconScreen)
    }
    
    func reset() {
        activeSheet = nil
        navigationPath = NavigationPath()
    }
}
