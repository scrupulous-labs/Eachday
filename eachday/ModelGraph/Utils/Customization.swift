import Foundation
import SwiftUI

enum HabitIcon: String {
    case circle = "circle"
    case square = "square"
}

enum HabitColor: String, CaseIterable {
    case blue = "blue" // a
    case indigo = "indigo"
    case red = "red" // a
    case orange = "orange" // a
    case yellow = "yellow"
    case green = "green"
    case emerald = "emerald" // a
    case cyan = "cyan" 
    case purple = "purple"
    case fuchsia = "fuchsia"
    case pink = "pink"
    case rose = "rose"
    
    var shade1: Color { shade200.opacity(0.225) }
    var shade2: Color { shade400.opacity(0.1) }
    var shade3: Color { shade500.opacity(0.4) }
    var shade4: Color { shade500.opacity(0.9) }
    var shade5: Color { shade600.opacity(0.9) }
    
    var shade50: Color {
        switch self {
        case .red:
            return Color(hex: "#fef2f2")
        case .yellow:
            return Color(hex: "#fefce8")
        case .blue:
            return Color(hex: "#eff6ff")
        case .orange:
            return Color(hex: "#fff7ed")
        case .indigo:
            return Color(hex: "#eef2ff")
        case .cyan:
            return Color(hex: "#ecfeff")
        case .green:
            return Color(hex: "#f0fdf4")
        case .emerald:
            return Color(hex: "#ecfdf5")
        case .purple:
            return Color(hex: "#faf5ff")
        case .fuchsia:
            return Color(hex: "#fdf4ff")
        case .pink:
            return Color(hex: "#fdf2f8")
        case .rose:
            return Color(hex: "#fff1f2")
        }
    }
    
    var shade100: Color {
        switch self {
        case .red:
            return Color(hex: "#fee2e2")
        case .yellow:
            return Color(hex: "#fef9c3")
        case .blue:
            return Color(hex: "#dbeafe")
        case .orange:
            return Color(hex: "#ffedd5")
        case .indigo:
            return Color(hex: "#e0e7ff")
        case .cyan:
            return Color(hex: "#cffafe")
        case .green:
            return Color(hex: "#dcfce7")
        case .emerald:
            return Color(hex: "#d1fae5")
        case .purple:
            return Color(hex: "#f3e8ff")
        case .fuchsia:
            return Color(hex: "#fae8ff")
        case .pink:
            return Color(hex: "#fce7f3")
        case .rose:
            return Color(hex: "#ffe4e6")
        }
    }

    var shade200: Color {
        switch self {
        case .red:
            return Color(hex: "#fecaca")
        case .yellow:
            return Color(hex: "#fef08a")
        case .blue:
            return Color(hex: "#bfdbfe")
        case .orange:
            return Color(hex: "#fed7aa")
        case .indigo:
            return Color(hex: "#c7d2fe")
        case .cyan:
            return Color(hex: "#a5f3fc")
        case .green:
            return Color(hex: "#bbf7d0")
        case .emerald:
            return Color(hex: "#a7f3d0")
        case .purple:
            return Color(hex: "#e9d5ff")
        case .fuchsia:
            return Color(hex: "#f5d0fe")
        case .pink:
            return Color(hex: "#fbcfe8")
        case .rose:
            return Color(hex: "#fecdd3")
        }
    }
    
    var shade300: Color {
        switch self {
        case .red:
            return Color(hex: "#fca5a5")
        case .yellow:
            return Color(hex: "#fde047")
        case .blue:
            return Color(hex: "#93c5fd")
        case .orange:
            return Color(hex: "#fcd34d")
        case .indigo:
            return Color(hex: "#a5b4fc")
        case .cyan:
            return Color(hex: "#67e8f9")
        case .green:
            return Color(hex: "#86efac")
        case .emerald:
            return Color(hex: "#6ee7b7")
        case .purple:
            return Color(hex: "#d8b4fe")
        case .fuchsia:
            return Color(hex: "#f0abfc")
        case .pink:
            return Color(hex: "#f9a8d4")
        case .rose:
            return Color(hex: "#fda4af")
        }
    }
    
    var shade400: Color {
        switch self {
        case .red:
            return Color(hex: "#f87171")
        case .yellow:
            return Color(hex: "#facc15")
        case .blue:
            return Color(hex: "#60a5fa")
        case .orange:
            return Color(hex: "#fb923c")
        case .indigo:
            return Color(hex: "#818cf8")
        case .cyan:
            return Color(hex: "#22d3ee")
        case .green:
            return Color(hex: "#4ade80")
        case .emerald:
            return Color(hex: "#34d399")
        case .purple:
            return Color(hex: "#c084fc")
        case .fuchsia:
            return Color(hex: "#e879f9")
        case .pink:
            return Color(hex: "#f472b6")
        case .rose:
            return Color(hex: "#fb7185")
        }
    }
    
    var shade500: Color {
        switch self {
        case .red:
            return Color(hex: "#ef4444")
        case .yellow:
            return Color(hex: "#eab308")
        case .blue:
            return Color(hex: "#3b82f6")
        case .indigo:
            return Color(hex: "#6366f1")
        case .cyan:
            return Color(hex: "#06b6d4")
        case .orange:
            return Color(hex: "#f97316")
        case .green:
            return Color(hex: "#22c55e")
        case .emerald:
            return Color(hex: "#10b981")
        case .purple:
            return Color(hex: "#a855f7")
        case .fuchsia:
            return Color(hex: "#d946ef")
        case .pink:
            return Color(hex: "#ec4899")
        case .rose:
            return Color(hex: "#f43f5e")
        }
    }
    
    var shade600: Color {
        switch self {
        case .red:
            return Color(hex: "#dc2626")
        case .yellow:
            return Color(hex: "#ca8a04")
        case .blue:
            return Color(hex: "#2563eb")
        case .indigo:
            return Color(hex: "#4f46e5")
        case .cyan:
            return Color(hex: "#0891b2")
        case .orange:
            return Color(hex: "#ea580c")
        case .green:
            return Color(hex: "#16a34a")
        case .emerald:
            return Color(hex: "#059669")
        case .purple:
            return Color(hex: "#9333ea")
        case .fuchsia:
            return Color(hex: "#c026d3")
        case .pink:
            return Color(hex: "#db2777")
        case .rose:
            return Color(hex: "#e11d48")
        }
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
}
