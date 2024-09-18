import SwiftUI

struct ProfileSectionApp: View {
    var onReorderHabits: () -> Void
    var onArchivedHabits: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Section {
            Button { onReorderHabits() } label: {
                HStack {
                    Text("Reorder Habits")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
            
            Button { onArchivedHabits() } label: {
                HStack {
                    Text("Archived Habits")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
        } header: {
            Text("App").padding(.leading, -8)
        }
    }
}
