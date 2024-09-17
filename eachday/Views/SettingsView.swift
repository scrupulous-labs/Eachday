import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        
                    }
                }
            }
        }
    }
}
