import SwiftUI

struct AppView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(ModelGraph.self) var modelGraph: ModelGraph
    @Bindable private var ui: AppViewModel = AppViewModel.instance
    
    var body: some View {
        NavigationStack(path: $ui.navigationPath) {
            ScrollView {
                if modelGraph.habits.filter({ $0.showInUI }).isEmpty {
                    VStack {
                        Button { ui.openNewHabitSheet(modelGraph) } label: {
                            Text("NEW HABIT")
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 76)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    AppViewHeader(
                        activeGroup: getActiveGroup(),
                        onEditGroup: ui.openEditHabitGroup,
                        onSelectGroup: ui.setActiveGroup,
                        onEditHabitOrder: ui.openEditHabitOrderSheet
                    )
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 16))
                    
                    LazyVStack(spacing: 0) {
                        ForEach(getActiveGroup().habitGroupItemsSorted, id: \.id) { item in
                            let habit = item.habit
                            if habit != nil && habit!.showInUI {
                                HabitCard(
                                    habit: habit!,
                                    editHabit: { ui.openEditHabitSheet(modelGraph, habit: habit!) },
                                    editHabitHistory: { ui.openEditHabitHistorySheet(habit: habit!) }
                                )
                                .padding([.bottom, .horizontal])
                                .onTapGesture { ui.openHabitDetailsScreen(habit: habit!) }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
            .navigationTitle("My Habits")
            .toolbar {
                ToolbarItem {
                    HStack(spacing: 16) {
                        Button { ui.openNewHabitSheet(modelGraph) } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .fontWeight(.bold)
                        }
//                        Button { ui.openSettingsSheet() } label: {
//                            Image(systemName: "person.circle")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 24, height: 24)
//                        }
                    }
                }
            }
            .sheet(item: $ui.activeSheet, onDismiss: {
                modelGraph.habits.forEach { $0.graphResetToDb() }
                modelGraph.habitGroups.forEach { $0.graphResetToDb() }
            }) { item in
                switch item {
                case AppViewSheet.settingsSheet:
                    SettingsView()
                    
                case AppViewSheet.editHabitOrderSheet:
                    EditHabitOrderView()
                    
                case AppViewSheet.editHabitSheet(let habit):
                    EditHabitView(
                        habit: habit,
                        canCancel: $ui.canInteractivelyDismissSheet,
                        attemptedToCancel: $ui.userAttemptedToDismissSheet
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
                    
                case AppViewSheet.editHabitHistorySheet(let habit):
                    EditHabitHistory(
                        habit: habit,
                        canCancel: $ui.canInteractivelyDismissSheet,
                        attemptedToCancel: $ui.userAttemptedToDismissSheet
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
                
                case AppViewSheet.editHabitGroupSheet(let habitGroup):
                    EditHabitGroupView(
                        habitGroup: habitGroup,
                        canCancel: $ui.canInteractivelyDismissSheet,
                        attemptedToCancel: $ui.userAttemptedToDismissSheet,
                        onSave: { }
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
            .navigationDestination(for: AppViewScreen.self) { destination in
                switch destination {
                case AppViewScreen.habitDetailsScreen(let habitId):
                    let habit = modelGraph.habits.first { $0.id == habitId }
                    if habit != nil {
                        HabitDetailsView(habit: habit!)
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
class AppViewModel {
    static let instance: AppViewModel = AppViewModel()
    
    var activeGroup: HabitGroupModel? = nil
    var activeSheet: AppViewSheet? = nil
    var currentSheetDent: PresentationDetent = PresentationDetent.large
    var userAttemptedToDismissSheet: Bool = false
    var canInteractivelyDismissSheet: Bool = true
    var navigationPath: NavigationPath = NavigationPath()
    
    func setActiveGroup(_ habitGroup: HabitGroupModel) { activeGroup = habitGroup }
    func openSettingsSheet() { activeSheet = AppViewSheet.settingsSheet }
    func openEditHabitOrderSheet() { activeSheet = AppViewSheet.editHabitOrderSheet }
    
    func openNewHabitSheet(_ modelGraph: ModelGraph) {
        let habitToEdit = HabitModel(modelGraph, markForDeletion: true)
        habitToEdit.addEmptyTask()
        habitToEdit.addToDefaultGroup()
        if activeGroup != nil && !activeGroup!.isDefault {
            habitToEdit.addToGroup(group: activeGroup!)
        }
        openEditHabitSheet(modelGraph, habit: habitToEdit)
    }
    
    func openEditHabitSheet(_ modelGraph: ModelGraph, habit: HabitModel) {
        activeSheet = AppViewSheet.editHabitSheet(habit)
        currentSheetDent = .large
        userAttemptedToDismissSheet = false
        canInteractivelyDismissSheet = true
    }
    
    func openEditHabitGroup(habitGroup: HabitGroupModel) {
        activeSheet = AppViewSheet.editHabitGroupSheet(habitGroup)
        currentSheetDent = .large
        userAttemptedToDismissSheet = false
        canInteractivelyDismissSheet = true
    }
    
    func openEditHabitHistorySheet(habit: HabitModel) {
        activeSheet = AppViewSheet.editHabitHistorySheet(habit)
        currentSheetDent = .large
        userAttemptedToDismissSheet = false
        canInteractivelyDismissSheet = true
    }
    
    func openHabitDetailsScreen(habit: HabitModel) {
        navigationPath.append(
            AppViewScreen.habitDetailsScreen(habitId: habit.id)
        )
    }
}
