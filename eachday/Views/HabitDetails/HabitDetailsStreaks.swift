import SwiftUI

struct HabitDetailsStreaks: View {
    var habit: HabitModel
    var completionsByDay: [Day: [TaskCompletionModel]]
    
    var currentStreak: Int {
        1
    }
    var LongestStreak: Int {
        1
    }
//    var completionArray: [Float] {
//        var res = Array<Float>()
//        let today = Day.today()
//        let thisWeek = today.week
//        let thisMonth = today.month
//        let startOfYear = Day.today()
//        
//        switch habit.frequency {
//        case .daily(_):
//            var day = startOfYear
//            while day <= today {
//                res.append(1.0)
//                day = day.next
//            }
//        case .weekly(_):
//            var week = startOfYear.week
//            while week <= thisWeek {
//                res.append(1.0)
//                week = week.next
//            }
//        case .monthly(_):
//            var month = startOfYear.month
//            while month <= thisMonth {
//                res.append(1.0)
//                month = month.next
//            }
//        }
//        return res
//    }
    
    
    
//    var completedCountByDay: [Day: Int] {
//        Array(completionsByDay.keys)
//            .filter { day in
//                let taskCount = habit.habitTasksUI.count
//                let completions = completionsByDay[day] ?? []
//                return (completions.count / taskCount) > 0
//            }
//    }
//    var completedCountByWeek: [Week: Int] {
//        completedDays
//            .reduce(into: [Int: [Day]]()) { res, day in
//                let weekOfYear = day.weekOfYear
//                res[weekOfYear] = (res[weekOfYear] ?? []) + [day]
//            }
//            .mapValues { $0.count }
//    }
//    var completedCountByMonth: [Month: Int] {
//        completedDays
//            .reduce(into: [Int: [Day]]()) { res, day in
//                let month = day.month.month
//                res[month] = (res[month] ?? []) + [day]
//            }
//            .mapValues { $0.count }
//    }
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 16) {
                Text("Current streak*")
                    .font(Font.subheadline.weight(.regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                HStack(alignment: .lastTextBaseline, spacing: 4) {
                    Text("12")
                        .font(Font.system(size: 32).weight(.bold))
                        .foregroundColor(habit.color.shade5)
                    Text("weeks")
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
                    Text("1")
                        .font(Font.system(size: 32).weight(.bold))
                        .foregroundColor(habit.color.shade5)
                    Text("weeks")
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
}
