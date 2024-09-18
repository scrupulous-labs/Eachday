import SwiftUI

struct EditHabitOrderHabits: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    var body: some View {
        Section {
            ForEach(modelGraph.habitsSorted, id: \.id) { habit in
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
            .onMove { offsets, to in moveHabit(offsets: offsets, to: to) }
        }
    }
    
    func moveHabit(offsets: IndexSet, to: Int) {
        var copy = modelGraph.habitsSorted
        let count = copy.count
        let from = Array(offsets).first
        
        if from != nil {
            copy.move(fromOffsets: offsets, toOffset: to)
            // inserted at array start
            if to == 0 && count >= 2 {
                copy[0].sortOrder = copy[1].sortOrder.prev()
                copy[0].save()
            // inserted at array end
            } else if to == count && count >= 2 {
                copy[count - 1].sortOrder = copy[count - 2].sortOrder.next()
                copy[count - 1].save()
            // moved from bottom to top and inserted in between array
            } else if from! > to && 0 < to && to < count - 1 && count >= 3  {
                copy[to].sortOrder = SortOrder.middle(
                    r1: copy[to - 1].sortOrder,
                    r2: copy[to + 1].sortOrder
                )
                copy[to].save()
            // moved from top to bottom and inserted in between array
            } else if from! < to && 0 < to - 1 && to - 1 < count - 1 && count >= 3 {
                copy[to - 1].sortOrder = SortOrder.middle(
                    r1: copy[to - 2].sortOrder,
                    r2: copy[to].sortOrder
                )
                copy[to - 1].save()
            }
        }
    }
}
