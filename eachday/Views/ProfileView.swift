import SwiftUI

struct ProfileView: View {
    @Bindable var ui: ProfileViewModel = ProfileViewModel.instance
    @Environment(\.dismiss) var dismiss
    @Environment(RootStore.self) var rootStore
    
    var body: some View {
        NavigationStack(path: $ui.navigationPath) {
            List {
                ProfileSectionApp(
                    onReorderHabits: ui.openEditHabitOrder,
                    onArchivedHabits: ui.openArchivedHabits
                )
                ProfileSectionSettings()
                ProfileSectionGeneral()
            }
            .preferredColorScheme(rootStore.settings.value.prefferedColorScheme)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Text("Done")
                    }
                }
            }
            .navigationDestination(for: ProfileViewScreen.self) { destination in
                switch destination {
                case ProfileViewScreen.editHabitOrder:
                    EditHabitOrderView()
                case ProfileViewScreen.archivedHabits:
                    ArchivedHabits()
                }
            }
        }
    }
}


@Observable
class ProfileViewModel {
    static var instance: ProfileViewModel = ProfileViewModel()
    
    var navigationPath: NavigationPath = NavigationPath()
    
    func openEditHabitOrder() {
        navigationPath.append(ProfileViewScreen.editHabitOrder)
    }
    
    func openArchivedHabits() {
        navigationPath.append(ProfileViewScreen.archivedHabits)
    }
    
    func reset() {
        navigationPath = NavigationPath()
        EditHabitOrderViewModel.instance.reset()
    }
}
