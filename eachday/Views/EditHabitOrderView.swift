import SwiftUI

struct EditHabitOrderView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ModelGraph.self) var modelGraph: ModelGraph
    @Bindable private var ui: EditHabitOrderViewModel = EditHabitOrderViewModel.instance

    var body: some View {
        let activeGroup = getActiveGroup()
        NavigationStack {
            List {
                Section { EditHabitOrderInGroup(group: activeGroup) } header: {
                    EditHabitOrderHeader(
                        activeGroup: activeGroup,
                        onSelectGroup: ui.setActiveGroup,
                        onNewGroup: { ui.openEditHabitGroup(modelGraph) },
                        onEditGroupOrder: ui.openEditHabitGroupOrder
                    )
                    .padding(EdgeInsets(top: 12, leading: -40, bottom: 12, trailing: -18))
                    .textCase(nil)
                }
                EditHabitOrderUngrouped(group: activeGroup)
            }
            .navigationTitle("Edit List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
            .sheet(item: $ui.activeSheet, onDismiss: {
                modelGraph.habitGroups.forEach { $0.graphResetToDb() }
            }) { item in
                switch item {
                case EditHabitOrderSheet.editHabitGroupOrder:
                    EditHabitGroupOrderView()
                
                case EditHabitOrderSheet.editHabitGroup(let habitGroup):
                    EditHabitGroupView(
                        habitGroup: habitGroup,
                        canCancel: $ui.canInteractivelyDismissSheet,
                        attemptedToCancel: $ui.userAttemptedToDismissSheet,
                        onSave: { ui.activeGroup = habitGroup }
                    )
                    .interactiveDismissDisabled(!ui.canInteractivelyDismissSheet)
                    .presentationDragIndicator(.hidden)
                    .presentationDetents(
                        ui.canInteractivelyDismissSheet ? [.large] : [.large, .fraction(0.95)],
                        selection: $ui.currentSheetDent
                    )
                    .onChange(of: ui.currentSheetDent) { oldVal, newVal in
                        if newVal != .large {
                            ui.currentSheetDent = .large
                            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                                ui.userAttemptedToDismissSheet = true
                            })
                        }
                    }
                }
            }
        }
    }
    
    func getActiveGroup() -> HabitGroupModel {
        ui.activeGroup ?? getFirstNonDefaultGroup() ?? modelGraph.defaultHabitGroup
    }
    func getFirstNonDefaultGroup() -> HabitGroupModel? {
        modelGraph.habitGroupsSorted.first { !$0.isDefault }
    }
}

@Observable
class EditHabitOrderViewModel {
    static let instance = EditHabitOrderViewModel()
    
    var activeGroup: HabitGroupModel? = nil
    var activeSheet: EditHabitOrderSheet? = nil
    var currentSheetDent: PresentationDetent = PresentationDetent.large
    var userAttemptedToDismissSheet: Bool = false
    var canInteractivelyDismissSheet: Bool = true
    
    func setActiveGroup(_ habitGroup: HabitGroupModel) {
        activeGroup = habitGroup
    }
    
    func openEditHabitGroupOrder() {
        activeSheet = EditHabitOrderSheet.editHabitGroupOrder
    }
    
    func openEditHabitGroup(_ modelGraph: ModelGraph) {
        let lastGroup = modelGraph.habitGroupsSorted.last
        let sortOrder = lastGroup?.sortOrder.next() ?? SortOrder.new()
        let groupToEdit = HabitGroupModel(modelGraph, sortOrder: sortOrder, markForDeletion: true)
        
        activeSheet = EditHabitOrderSheet.editHabitGroup(groupToEdit)
        currentSheetDent = .large
        userAttemptedToDismissSheet = false
        canInteractivelyDismissSheet = true
    }
}
