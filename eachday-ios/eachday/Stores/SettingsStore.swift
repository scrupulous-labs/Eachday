import Foundation

@Observable
class SettingsStore: Store {
    var saved: SettingsModel? = nil
    
    var value: SettingsModel {
        saved ?? SettingsModel(rootStore)
    }
    
    init(_ rootStore: RootStore) {
        super.init(rootStore: rootStore)
    }
}
