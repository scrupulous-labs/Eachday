import SwiftUI

struct EditHabitView: View {
    @Bindable var habit: HabitModel
    @Binding var canCancel: Bool
    @Binding var attemptedToCancel: Bool
    @Bindable var ui: EditHabitViewModel = EditHabitViewModel.instance
    
    @Environment(\.dismiss) var dismiss
    @Environment(ModelGraph.self) var modelGraph
    @FocusState private var focusedField: EditHabitFormField?

    var body: some View {
        NavigationStack(path: $ui.navigationPath) {
            Form {
                EditHabitSectionHabit(
                    habit: habit,
                    focusedField: $focusedField,
                    onFieldChange: onFieldChange
                )
                EditHabitSectionChecklist(
                    habit: habit,
                    focusedField: $focusedField,
                    onFieldChange: onFieldChange
                )
                EditHabitSectionGoal(
                    habit: habit,
                    focusedField: $focusedField,
                    onFieldChange: onFieldChange,
                    onChangeFrequency: ui.openSelectFrequencySheet,
                    onChangeReminders: ui.openSetRemindersScreen,
                    onChangeGroup: ui.openSelectGroupScreen
                )
                EditHabitSectionColor(
                    habit: habit
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
                    EditHabitSelectFrequency(habit: habit)
                        .presentationDetents([.fraction(0.65)])
                        .presentationDragIndicator(.visible)
                
                case EditHabitSheet.editGroupSheet(let habitGroup):
                    EditHabitGroupView(
                        habitGroup: habitGroup,
                        canCancel: $ui.canInteractivelyDismissSheet,
                        attemptedToCancel: $ui.userAttemptedToDismissSheet,
                        onSave: { }
                    )
                }
            }
            .navigationDestination(for: EditHabitScreen.self) { destination in
                switch destination {
                case EditHabitScreen.setRemindersScreen:
                    Text("")
                case EditHabitScreen.selectGroupScreen:
                    EditHabitSelectGroup(
                        habit: habit,
                        onNewGroup: { ui.openNewGroupSheet(modelGraph) }
                    )
                case EditHabitScreen.selectIconScreen:
                    Text("")
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
                focusedField = EditHabitFormField.habitName
            }
        }
    }
    
    func done() {
        if habit.isMarkedForDeletion { habit.graphUmarkForDeletion() }
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
    
    var navigationPath: NavigationPath = NavigationPath()
    var activeSheet: EditHabitSheet? = nil
    var currentSheetDent: PresentationDetent = PresentationDetent.large
    var userAttemptedToDismissSheet: Bool = false
    var canInteractivelyDismissSheet: Bool = true
    
    func openSetRemindersScreen() {
        navigationPath.append(EditHabitScreen.setRemindersScreen)
    }
    
    func openSelectGroupScreen() {
        navigationPath.append(EditHabitScreen.selectGroupScreen)
    }
    
    func openSelectIconScreen() {
        navigationPath.append(EditHabitScreen.selectIconScreen)
    }
    
    func openSelectFrequencySheet() {
        activeSheet = EditHabitSheet.selectFrequencySheet
    }
    
    func openNewGroupSheet(_ modelGraph: ModelGraph) {
        let lastGroup = modelGraph.habitGroupsSorted.first
        let sortOrder = lastGroup?.sortOrder.next() ?? SortOrder.new()
        let groupToEdit = HabitGroupModel(modelGraph, sortOrder: sortOrder, markForDeletion: true)
        
        activeSheet = EditHabitSheet.editGroupSheet(groupToEdit)
        currentSheetDent = .large
        userAttemptedToDismissSheet = false
        canInteractivelyDismissSheet = true
    }
}
