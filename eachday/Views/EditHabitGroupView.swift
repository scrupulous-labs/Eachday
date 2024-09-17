import SwiftUI

struct EditHabitGroupView: View {
    @Bindable var habitGroup: HabitGroupModel
    @Binding var canCancel: Bool
    @Binding var attemptedToCancel: Bool
    var onSave: () -> Void
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: EditHabitGroupFormField?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Group Name", text: $habitGroup.name)
                        .onChange(of: habitGroup.name, onFieldChange)
                        .focused($focusedField, equals: EditHabitGroupFormField.groupName)
                }
            }
            .navigationTitle(habitGroup.isMarkedForDeletion ? "New Group" : "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { cancel() } label: { Text("Cancel").fontWeight(.medium) }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { done() } label: { Text("Done").fontWeight(.medium) }
                }
            }
            .confirmationDialog(
                "Are you sure you want to discard this new group?",
                isPresented: $attemptedToCancel,
                titleVisibility: .visible
            ) {
                Button("Discard Changes", role: .destructive) { discardChanges() }
                Button("Keep Editing", role: .cancel) { }
            }
            .onAppear { focusedField = EditHabitGroupFormField.groupName }
        }
    }
    
    func done () { 
        if habitGroup.isMarkedForDeletion { habitGroup.unmarkForDeletion() }
        habitGroup.save(); onSave(); dismiss()
    }
    func cancel () { 
        if canCancel { discardChanges() }
        else { attemptedToCancel = true }
    }
    func discardChanges() { habitGroup.graphResetToDb(); dismiss() }
    func onFieldChange() { canCancel = !habitGroup.isGraphModified }
}
