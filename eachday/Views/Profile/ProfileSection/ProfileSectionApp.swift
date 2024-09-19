import SwiftUI

struct ProfileSectionApp: View {
    var onReorderHabits: () -> Void
    var onArchivedHabits: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    let iconHeight = 28.0
    let iconCornerRadius = 6.0
    
    var body: some View {
        Section {
            Button { onReorderHabits() } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.green)
                        
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)
                    
                    Text("Reorder Habits")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                }
            }
            
            Button { onArchivedHabits() } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.green)
                        
                        Image(systemName: "archivebox")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)
                    
                    Text("Archived Habits")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                }
            }
        } header: {
            Text("App").padding(.leading, -8)
        }
    }
}
