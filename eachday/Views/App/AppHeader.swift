import SwiftUI

struct AppViewHeader: View {
    var activeGroup: HabitGroupModel
    var onEditGroup: ((HabitGroupModel) -> Void)?
    var onSelectGroup: (HabitGroupModel) -> Void
    var onEditHabitOrder: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack {
            HabitGroupBar(
                leadingGap: 16, trailingGap: 16,
                activeGroup: activeGroup, 
                onTapGroup: onSelectGroup,
                onEditGroup: onEditGroup
            )
            .frame(maxWidth: .infinity)
            
            Divider().padding(.leading, -8)
            
            Button { onEditHabitOrder() } label: {
                Image(systemName: "arrow.up.arrow.down")
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
            .padding(.leading, -4)
            .frame(alignment: .trailing)
        }
    }
}
