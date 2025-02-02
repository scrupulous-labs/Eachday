import SwiftUI

struct ProfileView: View {
    @Bindable var ui: ProfileViewModel = ProfileViewModel.instance
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Environment(RootStore.self) var rootStore
    
    var body: some View {
        NavigationStack(path: $ui.navigationPath) {
            List {
                ProfileSectionPro(
                    onPurchasePro: ui.openPurchasePro
                )
                ProfileSectionApp(
                    onReorderHabits: ui.openReorderHabits,
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
                    Button { dismiss() } label: { Text("Done") }
                }
            }
            .navigationDestination(for: ProfileViewScreen.self) { destination in
                switch destination {
                case ProfileViewScreen.purchasePro:
                    ProfilePurchasePro(
                        dismiss: dismiss
                    )
                case ProfileViewScreen.reorderHabits:
                    ProfileReorderHabits(
                        dismiss: dismiss,
                        purchasePro: ui.openPurchasePro
                    )
                case ProfileViewScreen.archivedHabits:
                    ProfileArchivedHabits(
                        purchasePro: ui.openPurchasePro
                    )
                }
            }
        }
    }
}


@Observable
class ProfileViewModel {
    static var instance: ProfileViewModel = ProfileViewModel()
    
    var navigationPath: NavigationPath = NavigationPath()
    
    func openPurchasePro() {
        navigationPath.append(ProfileViewScreen.purchasePro)
    }
    
    func openReorderHabits() {
        navigationPath.append(ProfileViewScreen.reorderHabits)
    }
    
    func openArchivedHabits() {
        navigationPath.append(ProfileViewScreen.archivedHabits)
    }
    
    func reset() {
        navigationPath = NavigationPath()
        ProfilePurchaseProModel.instance.reset()
        ProfileReorderHabitsModel.instance.reset()
    }
}
