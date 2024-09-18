import SwiftUI

struct HabitGroupBar: View {
    var leadingGap: Double? = nil
    var trailingGap: Double? = nil
    var activeGroupIds: Set<UUID>
    var onTapGroup: (HabitGroupModel) -> Void
    var onEditGroup: ((HabitGroupModel) -> Void)? = nil
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 6) {
                if leadingGap != nil { Spacer().frame(width: leadingGap! - 6) }
                ForEach(
                    modelGraph.habitGroupsSorted.filter { !$0.habitGroupItemsSorted.isEmpty },
                    id: \.id
                ) { habitGroup in
                    let isActive = activeGroupIds.contains(habitGroup.id)
                    Text(habitGroup.name)
                        .font(Font.subheadline.weight(.medium))
                        .foregroundColor(isActive
                            ? (colorScheme == .light ? .white : .black)
                            : (colorScheme == .light ? .black : .white)
                        )
                        .padding(EdgeInsets(top: 5, leading: 11, bottom: 5, trailing: 11))
                        .background(isActive
                            ? Color(hex: colorScheme == .light ? "#111827" : "#E5E7EB")
                            : Color(hex: colorScheme == .light ? "#E4E4E7" : "#262626")
                        )
                        .cornerRadius(18)
                        .onTapGesture { onTapGroup(habitGroup) }
                        .contextMenu {
                            if onEditGroup != nil {
                                Button { onEditGroup!(habitGroup) } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                Divider()
                                Button { habitGroup.markForDeletion(); habitGroup.save() } label: {
                                    Label("Delete", systemImage: "trash").foregroundColor(.red)
                                }
                            }
                        }
                }
                if trailingGap != nil { Spacer().frame(width: trailingGap! - 6) }
            }
        }
        .scrollIndicators(.hidden)
    }
}
