import Foundation
import SwiftUI

struct EditHabitSectionChecklist: View {
    @Bindable var habit: HabitModel
    @FocusState.Binding var focusedField: EditHabitFormField?
    var onFieldChange: () -> ()
    
    @Environment(ModelGraph.self) var modelGraph: ModelGraph
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Section {
            ForEach(habit.habitTasksSorted.filter { $0.showInUI }, id: \.id) { task in
                @Bindable var task = task
                
                HStack {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .aspectRatio(contentMode: .fit)
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(habit.habitTasksSorted.count > 1 ? .red : .gray)
                        .frame(alignment: .leading)
                        .padding(.leading, 2)
                        .onTapGesture {
                            if habit.habitTasksSorted.count > 1 {
                                task.markForDeletion()
                                onFieldChange()
                            }
                        }
                    
                    TextField("Item Description", text: $task.description)
                        .onChange(of: task.description, onFieldChange)
                        .focused($focusedField, equals: EditHabitFormField.taskDescription(task))
                        .padding(.leading, 8)
                        .padding(.trailing, 4)
                    
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
            .onMove { offsets, to in
                habit.moveTask(offsets: offsets, to: to)
                onFieldChange()
            }
            
            Button {
                let task = habit.addEmptyTask()
                focusedField = EditHabitFormField.taskDescription(task)
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .aspectRatio(contentMode: .fit)
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(.green)
                        .padding(.leading, 2)
                    
                    Text("Add Item")
                        .font(Font.subheadline.weight(.light))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .padding(.leading, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        } header: {
            Text("checklist").padding(.leading, -8)
        } footer: {
            Text("Mark each of these items to complete the habit.")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
