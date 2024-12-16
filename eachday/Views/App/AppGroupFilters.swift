import SwiftUI

struct AppGroupFilters: View {
    var reorderGroups: () -> Void
    var leadingGap: Double? = 16
    var trailingGap: Double? = 16
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(RootStore.self) var rootStore
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 6) {
                if leadingGap != nil { Spacer().frame(width: leadingGap! - 6) }
                ForEach(
                    rootStore.habitGroups.sorted.filter { !$0.habitGroupItemsUI.isEmpty },
                    id: \.id
                ) { habitGroup in
                    let isFiltered = rootStore.habitGroups.filtered.contains(habitGroup.id)
                    Text(habitGroup.name)
                        .font(Font.system(size: 16, weight: .medium))
                        .foregroundColor(isFiltered
                            ? (colorScheme == .light ? .white : .black)
                            : (colorScheme == .light ? .black : .white)
                        )
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .background(isFiltered
                            ? Color(hex: colorScheme == .light ? "#111827" : "#E5E7EB")
                            : Color(hex: colorScheme == .light ? "#e2e2e2" : "#202020")
                        )
                        .cornerRadius(8)
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                            if rootStore.habitGroups.filtered.contains(habitGroup.id) {
                                rootStore.habitGroups.filtered.remove(habitGroup.id)
                            } else {
                                rootStore.habitGroups.filtered.insert(habitGroup.id)
                            }
                        }
                        .contextMenu {
                            Button { reorderGroups() } label: {
                                Label("Reorder Groups", systemImage: "arrow.up.arrow.down")
                            }
                        }
                }
                if trailingGap != nil { Spacer().frame(width: trailingGap! - 6) }
            }
        }
        .scrollIndicators(.hidden)
    }
}
