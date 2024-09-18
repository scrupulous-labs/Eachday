import SwiftUI

struct EditHabitOrderView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ModelGraph.self) var modelGraph: ModelGraph
    
    @State private var tab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            Picker("What is your favorite color?", selection: $tab) {
                Text("Habits").tag(0)
                Text("Groups").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: -4, leading: 96, bottom: 10, trailing: 96))

            List {
                if tab == 0 { EditHabitOrderHabits() }
                if tab == 1 { EditHabitOrderGroups() }
            }
        }
        .navigationTitle("Reorder List")
        .navigationBarTitleDisplayMode(.inline)
    }
}
