import SwiftUI

struct EditHabitSelectGroup: View {
    var habit: HabitModel
    @Bindable var group: HabitGroupModel
    var onFieldChange: () -> Void
    var onSaveGroup: () -> Void
    
    var cellSize = 40.0
    var cellCornerRadius = 6.0
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        List {
            Section {
                ForEach(modelGraph.habitGroupsUI, id: \.id) { group in
                    let habitInGroup = habit.belongsToGroup(group: group)
                    let iconName: String = habitInGroup ? "checkmark.circle.fill" : "circle"
                    let iconColor: Color = habitInGroup ? .green : .gray
                    Button {
                        if habit.belongsToGroup(group: group) {
                            habit.removeFromGroup(group: group)
                            onFieldChange()
                        } else {
                            habit.addToGroup(group: group)
                            onFieldChange()
                        }
                    } label: {
                        HStack {
                            Image(systemName: iconName)
                                .resizable()
                                .frame(width: 22, height: 22)
                                .foregroundColor(iconColor)
                                .padding(.trailing, 8)
                            Text(group.name)
                                .font(Font.headline.weight(.regular))
                                .foregroundColor(colorScheme == .light ? .black : .white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            } header: {
                Text("Groups")
            }
            
            Section {
                HStack(spacing: 12) {
                    TextField("New Group", text: $group.name)
                        .frame(maxWidth: .infinity)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: cellCornerRadius, style: .continuous)
                            .size(width: cellSize, height: cellSize)
                            .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#262626"))
                        
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .fontWeight(.regular)
                    }
                    .frame(width: cellSize, height: cellSize)
                    .onTapGesture { onSaveGroup() }
                }
                .padding(.vertical, 8)
                .listRowInsets(.init(top: 0, leading: 24, bottom: 0, trailing: 10))
            } header: {
                Text("Add Group")
            }
        }
    }
}
