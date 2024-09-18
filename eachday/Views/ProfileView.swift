import SwiftUI

struct ProfileView: View {
    @Bindable var ui: ProfileViewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
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
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .navigationDestination(for: ProfileViewScreen.self) { destination in
                switch destination {
                case ProfileViewScreen.editHabitOrder:
                    EditHabitOrderView()
                case ProfileViewScreen.archivedHabits:
                    Text("TEST")
                }
            }
        }
    }
}


@Observable
class ProfileViewModel {
    var navigationPath: NavigationPath = NavigationPath()
    
    func openEditHabitOrder() {
        navigationPath.append(ProfileViewScreen.editHabitOrder)
    }
    
    func openArchivedHabits() {
        navigationPath.append(ProfileViewScreen.archivedHabits)
    }
}
