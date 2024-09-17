import SwiftUI

struct HabitGroupBar: View {
    var leadingGap: Double? = nil
    var trailingGap: Double? = nil
    var activeGroup: HabitGroupModel
    var onTapGroup: (HabitGroupModel) -> Void
    var onEditGroup: ((HabitGroupModel) -> Void)? = nil
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if leadingGap != nil { Spacer().frame(width: leadingGap!) }
                ForEach(modelGraph.habitGroupsSorted, id: \.id) { habitGroup in
                    let isActive = habitGroup.id == activeGroup.id
                    Text(habitGroup.name)
                        .font(Font.subheadline.weight(.semibold))
                        .foregroundColor(isActive
                            ? (colorScheme == .light ? .white : .black)
                            : (colorScheme == .light ? .black : .white)
                        )
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .background(isActive
                            ? Color(hex: colorScheme == .light ? "#111827" : "#E5E7EB")
                            : Color(hex: colorScheme == .light ? "#E4E4E7" : "#262626")
                        )
                        .cornerRadius(18)
                        .onTapGesture { onTapGroup(habitGroup) }
                        .contextMenu {
                            if !habitGroup.isDefault && onEditGroup != nil {
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
                if trailingGap != nil { Spacer().frame(width: trailingGap!) }
            }
        }
        .scrollIndicators(.hidden)
    }
}
