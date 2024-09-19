import Foundation

protocol Settings: AnyObject {
    var savedTheme: Theme? { get set }
    var savedStartOfWeek: DayOfWeek? { get set }
}

extension Settings {
    func validate() -> Bool {
        return true
    }
    
    func equals(_ settings: Settings) -> Bool {
        savedTheme == settings.savedTheme &&
        savedStartOfWeek == settings.savedStartOfWeek
    }
    
    func copyFrom(_ settings: Settings) {
        self.savedTheme = settings.savedTheme
        self.savedStartOfWeek = settings.savedStartOfWeek
    }
}

enum Theme: Int {
    case light = 0
    case dark = 1
    case system = 2
}
