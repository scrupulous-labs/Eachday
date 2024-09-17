import SwiftUI

struct EditHabitOrderUngrouped: View {
    let group: HabitGroupModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        let unGroupedHabits = modelGraph.habits.filter {
            $0.habitGroupItems.count == 1
        }
        
        if !group.isDefault {
            Section {
                if unGroupedHabits.isEmpty {
                    VStack {
                        Text("🤷")
                            .font(.system(size: 42))
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("No more habits to add")
                            .font(Font.subheadline)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                ForEach(unGroupedHabits, id: \.id) { habit in
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .aspectRatio(contentMode: .fit)
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(.green)
                            .frame(alignment: .leading)
                            .padding(.leading, 2)
                            .onTapGesture {
                                habit.addToGroup(group: group)
                                habit.save()
                            }
                        
                        Text(habit.name)
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            } header: {
                Text("ungrouped habits")
            }
        }
    }
}
