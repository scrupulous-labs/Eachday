import Foundation
import SwiftUI

enum HabitColor: String, CaseIterable {
    case lightRed = "lightRed"
    case red = "red"
    case orange = "orange"
    case lightOrange = "lightOrange"
    case yellow = "yellow"
    case green = "green"
    case emerald = "emerald"
    case teal = "teal"
    case darkGreen = "darkGreen"
    case cyan = "cyan"
    case sky = "sky"
    case blue = "blue"
    case indigo = "indigo"
    case violet = "violet"
    case purple = "purple"
    case fuchsia = "fuchsia"
    case pink = "pink"
    case rose = "rose"
    
    static var all: [HabitColor] = [
        .cyan,
        .sky,
        .blue,
        .indigo,
        .violet,
        .purple,
        .fuchsia,
        .pink,
        .rose,
        .lightRed,
        .red,
        .orange,
        .lightOrange,
        .yellow,
        .green,
        .emerald,
        .teal,
        .darkGreen
    ]
    
    var color: Color {
        switch self {
        case .red:
            return Color(hex: "#E84C3D")
        case .lightRed:
            return Color(r: 221, g: 82, b: 76)
        case .orange:
            return Color(r: 232, g: 123, b: 54)
        case .lightOrange:
            return Color(r: 232, g: 162, b: 59)
        case .yellow:
            return Color(r: 226, g: 181, b: 62)
        case .green:
            return Color(r: 148, g: 202, b: 66)
        case .emerald:
            return Color(r: 94, g: 193, b: 105)
        case .teal:
            return Color(r: 84, g: 183, b: 134)
        case .darkGreen:
            return Color(r: 84, g: 182, b: 167)
        case .cyan:
            return Color(r: 82, g: 180, b: 209)
        case .sky:
            return Color(r: 76, g: 163, b: 228)
        case .blue:
            return Color(r: 79, g: 128, b: 239)
        case .indigo:
            return Color(r: 100, g: 102, b: 233)
        case .violet:
            return Color(r: 133, g: 94, b: 238)
        case .purple:
            return Color(r: 158, g: 90, b: 239)
        case .fuchsia:
            return Color(r: 200, g: 83, b: 231)
        case .pink:
            return Color(r: 219, g: 86, b: 152)
        case .rose:
            return Color(r: 225, g: 80, b: 99)
        }
    }
    
    var shadeLight: Color { color.opacity(0.1) }
    var shadeMedium: Color { color.opacity(0.6) }
    var shadeFull: Color { color }
    
    func calendarShade(percentage: Double) -> Color {
        if percentage > 0 {
            let minOpacity = 0.4
            let addOpacity = (1 - minOpacity) * percentage
            return color.opacity(minOpacity + addOpacity)
        }
        return .white.opacity(0)
    }
}

extension Color {
    init(hex: String) {
        var rgb: UInt64 = 0
        let cleanHexCode = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    init(r: Int, g: Int, b: Int) {
        let redValue = Double(r) / 255.0
        let greenValue = Double(g) / 255.0
        let blueValue = Double(b) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
