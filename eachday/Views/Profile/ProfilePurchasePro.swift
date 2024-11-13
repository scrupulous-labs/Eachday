import SwiftUI
import RevenueCat

struct ProfilePurchasePro: View {
    let dismiss: DismissAction
    @Bindable var ui = ProfilePurchaseProModel.instance
    
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
                            ProfilePurchaseProPackage(package: monthly!, selectedPackage: $ui.selectedPackage)
                            Divider().foregroundColor(colorScheme == .light ? .black : .white)
                            ProfilePurchaseProPackage(package: yearly!, selectedPackage: $ui.selectedPackage)
                            Divider().foregroundColor(colorScheme == .light ? .black : .white)
                            ProfilePurchaseProPackage(package: lifetime!, selectedPackage: $ui.selectedPackage)
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
                                .font(Font.system(size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("✓  Restore archived habits")
                                .font(Font.system(size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("✓  Support an Independent Developer")
                                .font(Font.system(size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("✓  Widgets and more coming soon")
                                .font(Font.system(size: 20))
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
                    switch ui.selectedPackage {
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(ui.hideBackButton)
        .toolbar {
            if ui.hideBackButton {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: { Text("close") }
                }
            }
        }
        .onDisappear { ui.hideBackButton = false }
    }
}

struct ProfilePurchaseProPackage: View {
    let package: Package
    @Binding var selectedPackage: PackageType
    @Environment(RootStore.self) var rootStore
    
    var headline: String {
        switch package.packageType {
        case .monthly: 
            return "Monthly - \(package.localizedPriceString)"
        case .annual:
            return "Yearly - \(package.localizedPriceString)"
        case .lifetime:
            return "Lifetime - \(package.localizedPriceString)"
        default:
            return ""
        }
    }
    
    var subheadline: String {
        switch package.packageType {
        case .monthly: 
            return "Billed monthly"
        case .annual:
            let pricePerMonth = package.storeProduct.pricePerMonth ?? 1.0
            let priceFormatter = package.storeProduct.priceFormatter
            let localizedPricePerMonth = priceFormatter?.string(from: pricePerMonth)
            return "\(localizedPricePerMonth ?? "") per month, billed Yearly"
        case .lifetime:
            return "One time payment, yours forever"
        default:
            return ""
        }
    }
    
    var body: some View {
        HStack() {
            VStack(spacing: 6) {
                HStack {
                    Text(headline)
                        .font(Font.system(size: 20).weight(.medium))
                        .padding(.trailing, 2)
                    if package.packageType == .annual {
                        Text("BEST VALUE")
                            .font(Font.caption.weight(.semibold))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 8)
                            .background(Color(hex: "#fef08a"))
                            .foregroundColor(Color(hex: "#854d0e"))
                            .cornerRadius(8)
                    }
                    Spacer()
                }
                
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

@Observable
class ProfilePurchaseProModel {
    static let instance: ProfilePurchaseProModel = ProfilePurchaseProModel()
    
    var selectedPackage: PackageType = .annual
    var hideBackButton: Bool = false
}
