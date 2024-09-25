import Foundation

enum Frequency: Hashable {
    case daily(times: Int)
    case weekly(times: Int)
    case monthly(times: Int)
    
    var repetitionsPerDay: Int {
        switch self {
        case .daily(let times):
            return times
        default:
            return 1
        }
    }
    
    var uiText: String {
        switch self {
        case .daily(let times) where times == 1:
            return "Daily"
        case .daily(let times):
            return "\(times) times a day"
        case .weekly(let times) where times == 1:
            return "Once a week"
        case .weekly(let times):
            return "\(times) times a week"
        case .monthly(let times) where times == 1:
            return "Once a month"
        case .monthly(let times):
            return "\(times) times a month"
        }
    }
    
    var streakUnit: String {
        switch self {
        case .daily(_): "days"
        case .weekly(_): "weeks"
        case .monthly(_): "months"
        }
    }
    
    var streakDefinition: String {
        switch self {
        case .daily(let times):
            times > 1 ? "atleast once a day" : "once a day"
        case .weekly(let times):
            times > 1 ? "\(times) times a week" : "once a week"
        case .monthly(let times):
            times > 1 ? "\(times) times a month" : "once a month"
        }
    }
    
    static func fromJson(json: String) -> Frequency? {
        let decoder = JSONDecoder()
        let jsonData = json.data(using: .utf8)!
        return try? decoder.decode(Frequency.self, from: jsonData)
    }
    
    func toJson() -> String {
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(self)
        return String(data: jsonData!, encoding: .utf8)!
    }
    
    mutating func incr() {
        switch self {
        case .daily(let times) where times < 9:
            self = .daily(times: times + 1)
        case .weekly(let times) where times < 6:
            self = .weekly(times: times + 1)
        case .monthly(let times) where times < 20:
            self = .monthly(times: times + 1)
        default:
            break
        }
    }
    
    mutating func decr() {
        switch self {
        case .daily(let times) where times > 1:
            self = .daily(times: times - 1)
        case .weekly(let times) where times > 1:
            self = .weekly(times: times - 1)
        case .monthly(let times) where times > 1:
            self = .monthly(times: times - 1)
        default:
            break
        }
    }
}

extension Frequency: Codable {
    enum CaseType: String, Codable {
        case daily
        case weekly
        case monthly
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case times
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let caseType = try container.decode(CaseType.self, forKey: CodingKeys.type)
        switch caseType {
        case .daily:
            let times = try container.decode(Int.self, forKey: CodingKeys.times)
            self = .daily(times: times)
        case .weekly:
            let times = try container.decode(Int.self, forKey: CodingKeys.times)
            self = .weekly(times: times)
        case .monthly:
            let times = try container.decode(Int.self, forKey: CodingKeys.times)
            self = .monthly(times: times)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .daily(let times):
            try container.encode(CaseType.daily.rawValue, forKey: CodingKeys.type)
            try container.encode(times, forKey: CodingKeys.times)
        case .weekly(let times):
            try container.encode(CaseType.weekly.rawValue, forKey: CodingKeys.type)
            try container.encode(times, forKey: CodingKeys.times)
        case .monthly( let times):
            try container.encode(CaseType.monthly.rawValue, forKey: CodingKeys.type)
            try container.encode(times, forKey: CodingKeys.times)
        }
    }
}
