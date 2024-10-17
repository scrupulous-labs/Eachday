import SwiftUI
import RevenueCat

struct ProfileSectionPro: View {
    var body: some View {
        Section {
            Button { subscribe() } label: { Text("Get Eachday Pro") }
        }
    }
    
    func subscribe() {
        Purchases.shared.getOfferings { offerings, error in
            if let packages = offerings?.current?.availablePackages {
                print(packages)
            }
        }
    }
}
