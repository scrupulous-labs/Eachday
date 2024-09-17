import SwiftUI

struct EditHabitGroupOrderView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ModelGraph.self) var modelGraph: ModelGraph
    
    var body: some View {
        NavigationStack {
            List {
                EdithabitGroupOrderList()
            }
            .navigationTitle("Edit Groups")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
