import Foundation
import RevenueCat

@Observable
class PurchaseStore: Store {
    var proMonthly: Package? = nil
    var proYearly: Package? = nil
    var proLifetime: Package? = nil

    var purchasedPro: Bool = false
    var isPurchasing: Bool = false
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
        loadCustomerInfo()
        loadOfferings()
    }

    func purchase(pkg: Package) {
        if !purchasedPro {
            isPurchasing = true
            Purchases.shared.purchase(package: pkg) { [self] _, _, _, _ in
                isPurchasing = false
                loadCustomerInfo()
            }
        }
    }
    
    func restorePurchase() {
        if !purchasedPro {
            isPurchasing = true
            Purchases.shared.restorePurchases { [self] _, _ in
                isPurchasing = false
                loadCustomerInfo()
            }
        }
    }
    
    func loadCustomerInfo() {
        Purchases.shared.getCustomerInfo { [self] customerInfo, error in
            let proKey = Constants.revenueCatProEntitlement
            if let proEntitlement = customerInfo?.entitlements.all[proKey], error == nil {
                purchasedPro = proEntitlement.isActive
            } else if error != nil {
                print(error!)
            } else {
                print("loadPurchases: No pro entitlement data")
            }
        }
    }
    
    func loadOfferings() {
        Purchases.shared.getOfferings { [self] offerings, error in
            if let currentOffering = offerings?.current, error == nil {
                currentOffering.availablePackages.forEach { pkg in
                    switch pkg.packageType {
                    case .monthly: proMonthly = pkg
                    case .annual: proYearly = pkg
                    case .lifetime: proLifetime = pkg
                    default: break
                    }
                }
            } else if error != nil {
                print(error!)
            } else {
                print("loadPurchases: No current offerings")
            }
        }
    }
}
