import SwiftUI

@Observable
class SettingsModel: Model<SettingsRecord>, Settings {
    var savedTheme: Theme?
    var savedStartOfWeek: WeekDay?
    
    var theme: Theme {
        get { savedTheme ?? .system }
        set { savedTheme = newValue }
    }
    var startOfWeek: WeekDay {
        get { savedStartOfWeek ?? .sunday}
        set { savedStartOfWeek = newValue }
    }
    var prefferedColorScheme: ColorScheme? {
        switch theme {
        case Theme.light: ColorScheme.light
        case Theme.dark: ColorScheme.dark
        case Theme.system: nil
        }
    }
    
    init(_ rootStore: RootStore, fromRecord: SettingsRecord) {
        self.savedTheme = fromRecord.savedTheme
        self.savedStartOfWeek = fromRecord.savedStartOfWeek
        super.init(rootStore, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ rootStore: RootStore) {
        self.savedTheme = nil
        self.savedStartOfWeek = nil
        super.init(rootStore, fromRecord: nil, markForDeletion: false)
    }
    
//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }
    
    override func toRecord() -> SettingsRecord { SettingsRecord(fromModel: self) }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
    override func onCreate() { rootStore.settings.saved = self }
    override func onDelete() { rootStore.settings.saved = nil }
}
