import Foundation

struct SortOrder: Hashable, Comparable {
    let rank: Double
    
    static func < (lhs: SortOrder, rhs: SortOrder) -> Bool {
        return lhs.rank < rhs.rank
    }
    
    static func == (lhs: SortOrder, rhs: SortOrder) -> Bool {
        return lhs.rank == rhs.rank
    }
    
    static func new() -> SortOrder {
        return SortOrder(rank: 0)
    }
    
    static func middle(r1: SortOrder, r2: SortOrder) -> SortOrder {
        return SortOrder(rank: (r1.rank + r2.rank) / 2)
    }
    
    func prev() -> SortOrder {
        return SortOrder(rank: rank - 1000)
    }
    
    func next() -> SortOrder {
        return SortOrder(rank: rank + 1000)
    }
}
