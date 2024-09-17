import SwiftUI

struct EditHabitOrderInGroup: View {
    let group: HabitGroupModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let groupItems = group.habitGroupItemsSorted.filter { $0.habit != nil }
        if groupItems.isEmpty {
            VStack {
                Text("Add habits to this list")
                    .font(Font.subheadline)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("👇")
                    .font(.system(size: 42))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        
        ForEach(groupItems, id: \.id) { groupItem in
            HStack {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .aspectRatio(contentMode: .fit)
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(group.isDefault ? .gray : .red)
                    .frame(alignment: .leading)
                    .padding(.leading, 2)
                    .onTapGesture {
                        if !group.isDefault {
                            groupItem.markForDeletion()
                            groupItem.save()
                        }
                    }
                
                Text(groupItem.habit!.name)
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
        .onMove { offsets, to in group.moveItem(offsets: offsets, to: to); group.save() }
    }
}
