import Foundation

final class Algorithms {
    static func longestStreak(completionArray: [Float]) -> [Double] {
        var res = 0
        var map = [Bool: Int]()
        var (start, end) = (0, 0)
        let completedArray: [Bool] = completionArray.map { $0 >= 1.0 }
        while end < completedArray.count {
            map[completedArray[end]] = (map[completedArray[end]] ?? 0) + 1
            while (map[false] ?? 0) > 0 && start <= end {
                if map[completedArray[start]] != nil {
                    map[completedArray[start]] = map[completedArray[start]]! - 1
                }
                start += 1
            }
            res = max(res, end - start + 1)
            end += 1
        }
        
        return Array(repeating: 1.0, count: res)
    }
    
    static func currentStreak(completionArray: [Float]) -> [Float] {
        let end = completionArray.count - 1
        var start = end
        while start >= 0 {
            if completionArray[start] < 1 { break }
            start -= 1
        }
        
        if end - start > 0 {
            if start > 0 { start -= 1 }
            return Array(completionArray[start...end])
        } else {
            return []
        }
    }
}
