import Foundation

enum Maybe<T: Hashable>: Hashable {
    case just(T)
    case nothing

    static func == (lhs: Maybe<T>, rhs: Maybe<T>) -> Bool {
        switch (lhs, rhs) {
        case (.just(let lhsValue), .just(let rhsValue)):
            return lhsValue == rhsValue
        case (.nothing, .nothing):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .just(let value):
            hasher.combine(value)
        case .nothing:
            hasher.combine("nothing")
        }
    }
}
