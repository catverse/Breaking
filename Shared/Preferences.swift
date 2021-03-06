import Foundation

struct Preferences: Codable, Equatable {
    var refresh = 15
    var hide = 30
    var providers = [Provider.guardian, .spiegel, .theLocal]
    var filter = Filter.all
    
    static func == (lhs: Preferences, rhs: Preferences) -> Bool {
        true
    }
}
