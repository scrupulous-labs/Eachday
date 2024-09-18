import SwiftUI

struct ProfileApp: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Section {
            Button {
                
            } label: {
                HStack {
                    Text("Reorder Habits")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
            
            Button {
                
            } label: {
                HStack {
                    Text("Archived Habits")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
        } header: {
            Text("App").padding(.leading, -8)
        }
    }
}
