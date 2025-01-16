import Foundation

final class Algorithms {
    static func longestStreak(completionArray: [HabitDayStatus]) -> [HabitDayStatus] {
        var res = 0
        var map = [HabitDayStatus: Int]()
        var (start, end) = (0, 0)
        
        let completed = completionArray.map { $0.eitherCompletedOrNot() }
        while end < completed.count {
            map[completed[end]] = (map[completed[end]] ?? 0) + 1
            while (map[.notCompleted] ?? 0) > 0 && start <= end {
                if map[completed[start]] != nil {
                    map[completed[start]] = map[completed[start]]! - 1
                }
                start += 1
            }
            res = max(res, end - start + 1)
            end += 1
        }
        
        return Array(repeating: .completed, count: res)
    }
    
    static func currentStreak(completionArray: [HabitDayStatus]) -> [HabitDayStatus] {
        let end = completionArray.count - 1
        var start = end
        while start >= 0 {
            if completionArray[start] != .completed { break }
            start -= 1
        }
        return Array(repeating: .completed, count: end - start)
    }
}
