import SwiftUI

@Observable
class SettingsModel: Model<SettingsRecord>, Settings {
    var savedTheme: Theme?
    var savedStartOfWeek: DayOfWeek?
    
    var theme: Theme {
        get { savedTheme ?? .system }
        set { savedTheme = newValue }
    }
    var startOfWeek: DayOfWeek {
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
    
    init(_ modelGraph: ModelGraph, fromRecord: SettingsRecord) {
        self.savedTheme = fromRecord.savedTheme
        self.savedStartOfWeek = fromRecord.savedStartOfWeek
        super.init(modelGraph, fromRecord: fromRecord, markForDeletion: false)
    }
    
    init(_ modelGraph: ModelGraph) {
        self.savedTheme = nil
        self.savedStartOfWeek = nil
        super.init(modelGraph, fromRecord: nil, markForDeletion: false)
    }
    
//
// MARK - OVERRIDES
//
    override var children: [ModelNode] { [] }
    override var isModified: Bool { record != nil && !equals(record!) }
    override var isValid: Bool { validate() }
    
    override func toRecord() -> SettingsRecord { SettingsRecord(fromModel: self) }
    override func addToGraph() { modelGraph.settings = self }
    override func removeFromGraph() { modelGraph.settings = nil }
    override func resetToDbRecord() { if record != nil { copyFrom(record!) } }
}
