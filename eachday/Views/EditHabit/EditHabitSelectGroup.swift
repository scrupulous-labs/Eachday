import SwiftUI

struct EditHabitSelectGroup: View {
    var habit: HabitModel
    var onNewGroup: () -> Void
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        List {
            Section {
                ForEach(modelGraph.habitGroupsUI, id: \.id) { group in
                    let habitInGroup = habit.belongsToGroup(group: group)
                    let iconName: String = habitInGroup ? "checkmark.circle.fill" : "circle"
                    let iconColor: Color = habitInGroup ? .green : .gray
                    Button {
                        if habitInGroup {
                            habit.removeFromGroup(group: group)
                        } else {
                            habit.addToGroup(group: group)
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
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            } header: {
                Text("Select Group").padding(.leading, -8)
            }
            
            Button { onNewGroup() } label: {
                Text("New Group")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
