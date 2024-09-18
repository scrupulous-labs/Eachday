import SwiftUI

struct EditHabitOrderHeader: View {
    let activeGroup: HabitGroupModel
    let onSelectGroup: (HabitGroupModel) -> Void
    let onNewGroup: () -> Void
    let onEditGroupOrder: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
//            HabitGroupBar(
//                leadingGap: 20, trailingGap: 20,
//                activeGroup: activeGroup, onTapGroup: onSelectGroup
//            )
//            .frame(maxWidth: .infinity)
            
            Divider().padding(.leading, -8)

            HStack(spacing: 10) {
                Button { onNewGroup() } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .fontWeight(.semibold)
                        .padding(9)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6).stroke(
                                colorScheme == .light ? Color(hex: "#1F2937") : .white,
                                lineWidth: 0.25
                            )
                        }
                }
                Button { onEditGroupOrder() } label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .fontWeight(.bold)
                        .padding(9)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6).stroke(
                                colorScheme == .light ? Color(hex: "#1F2937") : .white,
                                lineWidth: 0.25
                            )
                        }
                }
            }
            .padding(.leading, -6)
            .frame(alignment: .trailing)
        }
    }
}
