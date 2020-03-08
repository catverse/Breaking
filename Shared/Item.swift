import Foundation

struct Item: Identifiable, Hashable {
    static func spiegel(_ output: URLSession.DataTaskPublisher.Output) -> [Item] {
        String(decoding: output.0, as: UTF8.self).components(separatedBy: "<item>").dropFirst().map {
            var item = Item()
            content($0, tag: "guid").map { item.id = $0 }
            content($0, tag: "title").map { item.title = $0 }
            return item
        }
    }
    
    private static func content(_ string: String, tag: String) -> String? {
        string.components(separatedBy: "<" + tag + ">").last?.components(separatedBy: "</" + tag + ">").first
    }
    
    private(set) var id = ""
    private(set) var title = ""
    private(set) var description = ""
    private(set) var link = ""
    private(set) var date = ""
    
    func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
