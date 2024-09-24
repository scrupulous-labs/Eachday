import SwiftUI

struct HabitDetailsStreaks: View {
    var habit: HabitModel
    var completionsByDay: [Day: [TaskCompletionModel]]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 16) {
            let completions = completionArray
            let current = currentStreak(completions)
            
            VStack(spacing: 16) {
                Text("Current streak*")
                    .font(Font.subheadline.weight(.regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                HStack(alignment: .lastTextBaseline, spacing: 4) {
                    Text(floatToString(current))
                        .font(Font.system(size: 32).weight(.bold))
                        .foregroundColor(habit.color.shade5)
                    Text(habit.frequency.streakUnit)
                        .font(Font.system(size: 16).weight(.semibold))
                        .foregroundColor(habit.color.shade5)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
            .cornerRadius(10)
            
            
            VStack(spacing: 16) {
                Text("Longest streak*")
                    .font(Font.subheadline.weight(.regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                HStack(alignment: .lastTextBaseline, spacing: 4) {
                    Text(floatToString(longestStreak(completions)))
                        .font(Font.system(size: 32).weight(.bold))
                        .foregroundColor(habit.color.shade5)
                    Text(habit.frequency.streakUnit)
                        .font(Font.system(size: 16).weight(.semibold))
                        .foregroundColor(habit.color.shade5)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#1C1C1E"))
            .cornerRadius(10)
        }
    }
    
    var completionArray: [Float] {
        var res = Array<Float>()
        switch habit.frequency {
        case .daily(_):
            let completed = completedCountByDay
            let maxDay = completed.keys.max()
            var day = completed.keys.min()
            if day != nil && maxDay != nil {
                while day! <= maxDay! {
                    res.append((completed[day!] ?? 0) >= 1 ? 1.0 : 0.0)
                    day = day!.next
                }
            }
        case .weekly(let times):
            let completed = completedCountByWeek
            let maxWeek = completed.keys.max()
            var week = completed.keys.min()
            if week != nil && maxWeek != nil {
                while week! <= maxWeek! {
                    res.append(Float(completed[week!] ?? 0) / Float(times))
                    week = week!.next
                }
            }
        case .monthly(let times):
            let completed = completedCountByMonth
            let maxMonth = completed.keys.max()
            var month = completed.keys.min()
            if month != nil && maxMonth != nil {
                while month! <= maxMonth! {
                    res.append(Float(completedCountByMonth[month!] ?? 0) / Float(times))
                    month = month!.next
                }
            }
        }
        return res
    }
    var completedCountByDay: [Day: Int] {
        completionsByDay.mapValues { completions in
            let taskCount = habit.habitTasksUI.count
            return completions.count / taskCount
        }
    }
    var completedCountByWeek: [Week: Int] {
        completionsByDay.reduce(into: [Week: Int]()) { res, item in
            let (day, completions) = item
            let taskCount = habit.habitTasksUI.count
            let week = day.week
            res[week] = (res[week] ?? 0) + (completions.count / taskCount)
        }
    }
    var completedCountByMonth: [Month: Int] {
        completionsByDay.reduce(into: [Month: Int]()) { res, item in
            let (day, completions) = item
            let taskCount = habit.habitTasksUI.count
            let month = day.month
            res[month] = (res[month] ?? 0) + (completions.count / taskCount)
        }
    }
    
    
    func currentStreak(_ completions: [Float]) -> Float {
        0.0
    }
    func longestStreak(_ completions: [Float]) -> Float {
        return Algorithms.longestStreak(completionArray: completions)
            .reduce(Float(0.0)) { $0 + Float(min($1, 1)) }
    }
    func floatToString(_ value: Float) -> String {
        let formattedString = String(format: "%.2f", value)
        if formattedString.hasSuffix(".00") {
            return formattedString.replacingOccurrences(of: ".00", with: "")
        } else if formattedString.hasSuffix("0") {
            return formattedString.replacingOccurrences(of: ".0", with: "")
        }
        return formattedString
    }
}
