import SwiftUI
import RevenueCat

struct ProfileSectionPro: View {
    let onPurchasePro: () -> Void
    
    var body: some View {
        Section {
            Button { onPurchasePro() } label: { Text("Get Eachday Pro") }
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
