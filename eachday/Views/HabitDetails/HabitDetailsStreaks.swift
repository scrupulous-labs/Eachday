import SwiftUI

struct HabitDetailsStreaks: View {
    var habit: HabitModel
    var completionsByDay: [Day: [TaskCompletionModel]]
    var completionsByDayAll: [Day: [TaskCompletionModel]]
    
    var currentStreak: Double {
        Algorithms.currentStreak(
            completionArray: completionArray(
                completionsByDayAll,
                maxDay: Day.yesterday()
            )
        )
        .reduce(Double(0)) { $0 + $1.percentage }
    }
    
    var longestStreak: Double {
        Algorithms.longestStreak(
            completionArray: completionArray(
                completionsByDay
            )
        )
        .reduce(Double(0)) { $0 + $1.percentage }
    }
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                VStack(spacing: 16) {
                    Text("Current streak*")
                        .font(Font.subheadline.weight(.regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
                        Text(doubleToString(currentStreak))
                            .font(Font.system(size: 32).weight(.bold))
                            .foregroundColor(habit.color.shadeFull)
                        Text(habit.frequency.streakUnit)
                            .font(Font.system(size: 16).weight(.semibold))
                            .foregroundColor(habit.color.shadeFull)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#000000"))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            colorScheme == .light ? .black.opacity(0.25) : Color(hex: "#909090"),
                            lineWidth: 0.25
                        )
                }
                
                
                VStack(spacing: 16) {
                    Text("Longest streak*")
                        .font(Font.subheadline.weight(.regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
                        Text(doubleToString(longestStreak))
                            .font(Font.system(size: 32).weight(.bold))
                            .foregroundColor(habit.color.shadeFull)
                        Text(habit.frequency.streakUnit)
                            .font(Font.system(size: 16).weight(.semibold))
                            .foregroundColor(habit.color.shadeFull)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: colorScheme == .light ? "#FFFFFF" : "#000000"))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            colorScheme == .light ? .black.opacity(0.25) : Color(hex: "#909090"),
                            lineWidth: 0.25
                        )
                }
            }
            
            Text("* completed \(habit.frequency.streakDefinition)")
                .font(Font.caption.weight(.light))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    func completionArray(
        _ completionsByDay: [Day: [TaskCompletionModel]],
        maxDay: Day? = nil
    ) -> [HabitDayStatus] {
        var res = Array<HabitDayStatus>()
        switch habit.frequency {
        case .daily(let times):
            let completed = completedCountByDay(completionsByDay)
            let maxDay = maxDay ?? completed.keys.max()
            var day = completed.keys.min()
            if day != nil && maxDay != nil {
                while day! <= maxDay! {
                    let percentage = Double(completed[day!] ?? 0) / Double(times)
                    res.append(HabitDayStatus.fromPercentage(percentage))
                    day = day!.next
                }
            }
        case .weekly(let times):
            let completed = completedCountByWeek(completionsByDay)
            let maxWeek = maxDay?.week ?? completed.keys.max()
            var week = completed.keys.min()
            if week != nil && maxWeek != nil {
                while week! <= maxWeek! {
                    let percentage = Double(completed[week!] ?? 0) / Double(times)
                    res.append(HabitDayStatus.fromPercentage(percentage))
                    week = week!.next
                }
            }
        case .monthly(let times):
            let completed = completedCountByMonth(completionsByDay)
            let maxMonth = maxDay?.month ?? completed.keys.max()
            var month = completed.keys.min()
            if month != nil && maxMonth != nil {
                while month! <= maxMonth! {
                    let percentage = Double(completed[month!] ?? 0) / Double(times)
                    res.append(HabitDayStatus.fromPercentage(percentage))
                    month = month!.next
                }
            }
        }
        return res
    }
    
    func completedCountByDay(
        _ completionsByDay: [Day: [TaskCompletionModel]]
    ) -> [Day: Int] {
        completionsByDay.mapValues { completions in
            let taskCount = habit.habitTasksUI.count
            return completions.count / taskCount
        }
    }
    
    func completedCountByWeek(
        _ completionsByDay: [Day: [TaskCompletionModel]]
    ) -> [Week: Int] {
        completionsByDay.reduce(into: [Week: Int]()) { res, item in
            let (day, completions) = item
            let taskCount = habit.habitTasksUI.count
            let week = day.week
            res[week] = (res[week] ?? 0) + (completions.count / taskCount)
        }
    }
    
    func completedCountByMonth(
        _ completionsByDay: [Day: [TaskCompletionModel]]
    ) -> [Month: Int] {
        completionsByDay.reduce(into: [Month: Int]()) { res, item in
            let (day, completions) = item
            let taskCount = habit.habitTasksUI.count
            let month = day.month
            res[month] = (res[month] ?? 0) + (completions.count / taskCount)
        }
    }
    
    func doubleToString(_ value: Double) -> String {
        let formattedString = String(format: "%.2f", value)
        if formattedString.hasSuffix(".00") {
            return formattedString.replacingOccurrences(of: ".00", with: "")
        } else if formattedString.hasSuffix("0") {
            return formattedString.replacingOccurrences(of: ".0", with: "")
        }
        return formattedString
    }
}
