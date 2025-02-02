import SwiftUI

struct ProfileArchivedHabits: View {
    let purchasePro: () -> Void
    let headerHeight = 44.0
    let headerIconHeight = 38.0
    let iconCornerRadius = 6.0
    let today = Day.today()
    var iconForegroundColor: Color { colorScheme == .light
        ? Color.black
        : Color.white
    }
    @Environment(\.colorScheme) private var colorScheme
    @Environment(RootStore.self) var rootStore
    
    var body: some View {
        List {
            Section {
                let archivedHabits = rootStore.habits.archived
                if archivedHabits.isEmpty {
                    Text("No archived habits")
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                ForEach(archivedHabits, id: \.id) { habit in
                    HStack(spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                                .size(width: headerIconHeight, height: headerIconHeight)
                                .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
                                .overlay {
                                    RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                                        .size(width: headerIconHeight, height: headerIconHeight)
                                        .fill(habit.color.shadeLight)
                                }
                            Image(systemName: colorScheme == .light ? habit.icon.symbol : habit.icon.symbolDark)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(iconForegroundColor)
                                .fontWeight(.light)
                        }
                        .frame(width: headerIconHeight, height: headerIconHeight)
                        
                        Text("\(habit.name)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.subheadline.weight(.medium))
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .frame(maxWidth: .infinity)
                        
                        Menu {
                            Button {
                                if rootStore.purchases.purchasedPro {
                                    habit.unarchive(); habit.save()
                                } else {
                                    purchasePro()
                                }
                            } label: {
                                Label("Unarchive", systemImage: "archivebox")
                            }
                            Button { habit.markForDeletion(); habit.save()  } label: {
                                Label("Delete permanently", systemImage: "trash").foregroundColor(.red)
                            }
                        } label: {
                            ZStack {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .fontWeight(.regular)
                                    .offset(x: 8, y: 0)
                            }
                            .frame(width: headerIconHeight, height: headerIconHeight)
                        }
                    }
                    .frame(height: headerHeight)
                }
            } header: {
                Text("Archived Habits").padding(.leading, -8)
            }
        }
    }
}
