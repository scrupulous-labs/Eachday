import SwiftUI

struct EditHabitSelectGroup: View {
    var habit: HabitModel
    var onNewGroup: () -> Void
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        List {
            Section {
                ForEach(
                    modelGraph.habitGroupsSorted.filter { !$0.isDefault },
                    id: \.id
                ) { group in
                    let habitInGroup = habit.belongsToGroup(group: group)
                    let iconName: String = habitInGroup  ? "checkmark.circle.fill" : "circle"
                    let iconColor: Color = habitInGroup ? .green : .gray
                    
                    HStack {
                        Text(group.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: iconName)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(iconColor)
                    }
                    .onTapGesture {
                        habit.addToGroup(group: group)
                    }
                }
            } header: {
                Text("Select Group").padding(.leading, -8)
            }
            
            Button { onNewGroup() } label: {
                Text("New Group")
            }
        }
    }
}
