import SwiftUI

struct EditHabitOrderHabits: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(RootStore.self) var rootStore
    
    var body: some View {
        Section {
            if rootStore.habits.sorted.isEmpty {
                Text("No Habits")
                    .padding(.vertical, 32)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            ForEach(rootStore.habits.sorted, id: \.id) { habit in
                HStack {
                    Text(habit.name)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 22, height: 11)
                        .aspectRatio(contentMode: .fit)
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(Color(hex: "#9CA3AF"))
                        .fontWeight(.light)
                        .frame(alignment: .trailing)
                        .padding(.trailing, 2)
                }
                
            }
            .onMove { offsets, to in rootStore.habits.moveHabit(offsets: offsets, to: to) }
        }
    }
}
