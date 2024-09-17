import SwiftUI

@main
struct eachdayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppView().environment(appDelegate.modelGraph)
        }
    }
}


final class AppDelegate: NSObject, UIApplicationDelegate {
    let modelGraph: ModelGraph = try! ModelGraph.makeGraph()
    
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        .portrait
    }
}
