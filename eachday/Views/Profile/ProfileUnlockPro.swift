import SwiftUI
import RevenueCat

struct ProfileUnlockPro: View {
    @State var selectedPackage: PackageType = .annual
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(RootStore.self) var rootStore
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 8) {
                    let monthly = rootStore.purchases.proMonthly
                    let yearly = rootStore.purchases.proYearly
                    let lifetime = rootStore.purchases.proLifetime
                    if monthly != nil && yearly != nil && lifetime != nil {
                        VStack(spacing: 2) {
                            ProfileUnlockProPackage(package: monthly!, selectedPackage: $selectedPackage)
                            Divider().foregroundColor(colorScheme == .light ? .black : .white)
                            ProfileUnlockProPackage(package: yearly!, selectedPackage: $selectedPackage)
                            Divider().foregroundColor(colorScheme == .light ? .black : .white)
                            ProfileUnlockProPackage(package: lifetime!, selectedPackage: $selectedPackage)
                        }
                        .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#000000"))
                        .cornerRadius(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    colorScheme == .light ? .black.opacity(0.25) : Color(hex: "#909090"),
                                    lineWidth: 0.25
                                )
                        }
                        .padding(.horizontal, 16)
                        
                        Button { rootStore.purchases.restorePurchase() } label: {
                            Text("Already subscribed? Restore purchase")
                                .font(Font.subheadline)
                        }
                        
                        VStack(spacing: 24) {
                            Text("✓  Unlimited Habits")
                                .foregroundColor(Color(hex: "#4B5563"))
                                .font(Font.system(size: 18).weight(.medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("✓  Restore archived habits")
                                .foregroundColor(Color(hex: "#4B5563"))
                                .font(Font.system(size: 18).weight(.medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("✓  Support an Independent Developer")
                                .foregroundColor(Color(hex: "#4B5563"))
                                .font(Font.system(size: 18).weight(.medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("✓  Widgets and more coming soon")
                                .foregroundColor(Color(hex: "#4B5563"))
                                .font(Font.system(size: 18).weight(.medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.top, 48)
                        .padding(.leading, 28)
                    }
                }
                .padding(.vertical, 16)
            }
            .scrollIndicators(.hidden)
            .background(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
            
            Button {
                if !rootStore.purchases.isPurchasing {
                    switch selectedPackage {
                    case .monthly:
                        if let monthly = rootStore.purchases.proMonthly {
                            rootStore.purchases.purchase(pkg: monthly)
                        }
                    case .annual:
                        if let yearly = rootStore.purchases.proYearly {
                            rootStore.purchases.purchase(pkg: yearly)
                        }
                    case .lifetime:
                        if let lifetime = rootStore.purchases.proLifetime {
                            rootStore.purchases.purchase(pkg: lifetime)
                        }
                    default: break
                    }
                }
            } label: {
                if rootStore.purchases.isPurchasing {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                        .tint(.white)
                } else {
                    Text("Continue")
                        .font(Font.system(size: 20).weight(.medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 6)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 24)
        }
        .navigationTitle("Unlock Eachday Pro")
    }
}

struct ProfileUnlockProPackage: View {
    let package: Package
    @Binding var selectedPackage: PackageType
    @Environment(RootStore.self) var rootStore
    
    var headline: String {
        switch package.packageType {
        case .monthly: "Monthly - \(package.localizedPriceString)"
        case .annual: "Yearly - \(package.localizedPriceString)"
        case .lifetime: "Lifetime - \(package.localizedPriceString)"
        default: ""
        }
    }
    
    var subheadline: String {
        switch package.packageType {
        case .monthly: "Billed monthly"
        case .annual: "Billed Yearly - Best Value"
        case .lifetime: "One time payment, yours forever"
        default: ""
        }
    }
    
    var body: some View {
        HStack() {
            VStack(spacing: 4) {
                Text(headline)
                    .font(Font.system(size: 20).weight(.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(subheadline)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 16).weight(.regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 16)
            .padding(.leading, 16)
            
            ZStack {
                Image(systemName: "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .fontWeight(.ultraLight)
                
                if selectedPackage == package.packageType {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .frame(width: 28, height: 28)
                }
            }
            .padding(.trailing, 16)
        }
        .contentShape(Rectangle())
        .onTapGesture { selectedPackage = package.packageType }
    }
}
