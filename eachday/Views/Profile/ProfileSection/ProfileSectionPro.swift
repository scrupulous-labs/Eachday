import SwiftUI
import RevenueCat

struct ProfileSectionPro: View {
    let onPurchasePro: () -> Void
    
    var body: some View {
        Section {
            Button { onPurchasePro() } label: {
                VStack(spacing: 10) {
                    Text("Get Eachday Pro  🎁")
                        .foregroundColor(Color(hex: "#030712"))
                        .font(Font.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("Support an independent developer, unlock unlimited habits and much more")
//                        .foregroundColor(Color(hex: "#4b5563"))
//                        .font(Font.system(size: 14).weight(.medium))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .lineSpacing(3)
                }
            }
        }
        .listRowBackground(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(r: 244, g: 221, b: 130),
                    Color(r: 238, g: 208, b: 95)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
