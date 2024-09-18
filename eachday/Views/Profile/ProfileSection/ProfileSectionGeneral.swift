import SwiftUI

struct ProfileSectionGeneral: View {
    @Environment(\.colorScheme) var colorScheme
    
    let iconHeight = 28.0
    let iconCornerRadius = 6.0
    
    var body: some View {
        Section {
            Button {
                
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.green)
                        
                        Image(systemName: "star")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)

                    Text("Rate app")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.blue)
                        
                        Image(systemName: "paperplane")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)

                    Text("Send Feedback")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.cyan)
                        
                        Image(systemName: "person.2")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)
                    
                    Text("Follow on Twitter")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.indigo)
                        
                        Image(systemName: "globe")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)

                    Text("Website")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                        .padding(.trailing, -2)
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.mint)
                        
                        Image(systemName: "hand.raised")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)

                    Text("Privacy Policy")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                        .padding(.trailing, -2)
                }
            }
            
            Button {
                
            } label: {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: iconCornerRadius, style: .continuous)
                            .size(width: iconHeight, height: iconHeight)
                            .fill(.gray)
                        
                        Image(systemName: "lock")
                            .resizable()
                            .fontWeight(.bold)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .frame(width: iconHeight, height: iconHeight)

                    Text("Terms of use")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#9CA3AF"))
                        .padding(.trailing, -2)
                }
            }
        } header: {
            Text("General").padding(.leading, -8)
        } footer: {
            Text("Made with love")
                .padding(EdgeInsets(top: 16, leading: -8, bottom: 0, trailing: 8))
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
