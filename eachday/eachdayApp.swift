import SwiftUI
import RevenueCat

@main
struct eachdayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        Purchases.configure(
          with: Configuration.Builder(withAPIKey: "appl_wGmJhBUKzuUgmEbccKOWFFVHCkR")
            .with(appUserID: String(appDelegate.rootStore.settings.value.startOfWeek.rawValue))
            .build()
        )
        Purchases.logLevel = .verbose
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
