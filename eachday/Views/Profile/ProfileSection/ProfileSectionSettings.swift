import SwiftUI

struct ProfileSectionSettings: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(ModelGraph.self) var modelGraph
    
    let iconHeight = 28.0
    let iconCornerRadius = 6.0
    
    var body: some View {
        @Bindable var settings = modelGraph.settingsUI
        Section {
            Picker(selection: $settings.theme) {
                Text("Light").tag(Theme.light)
                Text("Dark").tag(Theme.dark)
                Text("System").tag(Theme.system)
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
            .onChange(of: settings.theme) { _, _ in settings.save() }
            
            
            Picker(selection: $settings.startOfWeek) {
                Text("Sunday").tag(WeekDay.sunday)
                Text("Monday").tag(WeekDay.monday)
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
            .onChange(of: settings.startOfWeek) { _, _ in settings.save() }
        } header: {
            Text("Settings").padding(.leading, -8)
        }
    }
}
