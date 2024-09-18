import SwiftUI

struct ProfileSectionSettings: View {
    @Environment(\.colorScheme) var colorScheme
    
    let iconHeight = 28.0
    let iconCornerRadius = 6.0
    @State var theme: String = "System"
    @State var startOfWeek: String = "Monday"
    
    var body: some View {
        Section {
            Picker(selection: $theme) {
                Text("Dark").tag("Dark")
                Text("Light").tag("Light")
                Text("System").tag("System")
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.black)
                        
                        Image(systemName: "paintpalette")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)
                    
                    Text("Theme")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
            .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Picker(selection: $theme) {
                Text("Sunday").tag("Sunday")
                Text("Monday").tag("Monday")
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.mint)
                        
                        Image(systemName: "calendar")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)
                    
                    Text("Start of week")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }
            .listRowInsets(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
        } header: {
            Text("Settings").padding(.leading, -8)
        }
    }
}
