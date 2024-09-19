import SwiftUI

struct EditHabitOrderView: View {
    @Bindable var ui = EditHabitOrderViewModel.instance
    @Environment(ModelGraph.self) var modelGraph: ModelGraph

    var body: some View {
        VStack(spacing: 0) {
            Picker("What is your favorite color?", selection: $ui.tab) {
                Text("Habits").tag(0)
                Text("Groups").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: -4, leading: 96, bottom: 10, trailing: 96))

            List {
                if ui.tab == 0 { EditHabitOrderHabits() }
                if ui.tab == 1 { EditHabitOrderGroups() }
            }
        }
        .navigationTitle("Reorder List")
        .navigationBarTitleDisplayMode(.inline)
    }
}

@Observable
class EditHabitOrderViewModel {
    static var instance: EditHabitOrderViewModel = EditHabitOrderViewModel()
    
    var tab: Int = 0
    
    func reset() {
        tab = 0
    }
}
