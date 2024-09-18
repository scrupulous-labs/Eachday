import SwiftUI

struct ProfileSettings: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Section {
            Button {
                
            } label: {
                HStack {
                    Text("Theme")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
            
            Button {
                
            } label: {
                HStack {
                    Text("Start of week")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
        } header: {
            Text("Settings").padding(.leading, -8)
        }
    }
}
