import SwiftUI
import RevenueCat

@main
struct eachdayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        let config = Configuration
            .Builder(withAPIKey: Constants.revenueCatApiKey)
            .with(storeKitVersion: .storeKit2)
            .build()
        Purchases.configure(with: config)
        Purchases.logLevel = .debug
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(appDelegate.rootStore)
                .preferredColorScheme(appDelegate.rootStore.settings.value.prefferedColorScheme)
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    let rootStore: RootStore = try! RootStore.makeStore()
    
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        .portrait
    }
}
