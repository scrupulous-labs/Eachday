import SwiftUI

struct AppView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(RootStore.self) var rootStore: RootStore
    @Bindable private var ui: AppViewModel = AppViewModel.instance
    
    var body: some View {
        NavigationStack(path: $ui.navigationPath) {
            ScrollView {                
                if rootStore.habits.sorted.isEmpty {
                    VStack {
                        Button { ui.openNewHabitSheet(rootStore) } label: { Text("NEW HABIT") }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 76)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    LazyVStack(spacing: 0) {
                        AppGroupFilters()
                            .padding(.top, 8)
                            .padding(.bottom, 16)
                        
                        ForEach(rootStore.habits.filtered, id: \.id) { habit in
                            HabitCard(
                                habit: habit,
                                editHabit: { ui.openEditHabitSheet(rootStore, habit: habit) },
                                editHabitHistory: { ui.openEditHabitHistorySheet(habit: habit) }
                            )
                            .padding([.bottom, .horizontal])
                            .onTapGesture { ui.openHabitDetailsScreen(habit: habit) }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Eachday")
                        .font(Font.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        Button { ui.openNewHabitSheet(rootStore) } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .fontWeight(.regular)
                                .foregroundColor(.blue)
                        }
                        Button { ui.openProfileSheet() } label: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .fontWeight(.regular)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.trailing, 2)
                }
            }
            .sheet(item: $ui.activeSheet, onDismiss: {
                rootStore.habits.all.forEach { $0.graphResetToDb() }
                rootStore.habitGroups.all.forEach { $0.graphResetToDb() }
                ProfileViewModel.instance.reset()
                EditHabitViewModel.instance.reset()
            }) { item in
                switch item {
                case AppViewSheet.profileSheet:
                    ProfileView()
                    
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
                }
            }
            .navigationDestination(for: AppViewScreen.self) { destination in
                switch destination {
                case AppViewScreen.habitDetailsScreen(let habitId):
                    let habit = rootStore.habits.all.first { $0.id == habitId }
                    if habit != nil {
                        HabitDetailsView(habit: habit!)
                    }
                }
            }
        }
    }
}


@Observable
class AppViewModel {
    static let instance: AppViewModel = AppViewModel()
    
    var activeSheet: AppViewSheet? = nil
    var currentSheetDent: PresentationDetent = PresentationDetent.large
    var userAttemptedToDismissSheet: Bool = false
    var canInteractivelyDismissSheet: Bool = true
    var navigationPath: NavigationPath = NavigationPath()
    
    func openProfileSheet() {
        activeSheet = AppViewSheet.profileSheet
    }
    
    func openEditHabitOrderSheet() {
        activeSheet = AppViewSheet.editHabitOrderSheet
    }
    
    func openNewHabitSheet(_ rootStore: RootStore) {
        let lastHabit = rootStore.habits.sorted.last
        let sortOrder = lastHabit?.sortOrder.next() ?? SortOrder.new()
        let habitToEdit = HabitModel(rootStore, sortOrder: sortOrder, markForDeletion: true)
        habitToEdit.addEmptyTask()
        openEditHabitSheet(rootStore, habit: habitToEdit)
    }
    
    func openEditHabitSheet(_ rootStore: RootStore, habit: HabitModel) {
        activeSheet = AppViewSheet.editHabitSheet(habit)
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
