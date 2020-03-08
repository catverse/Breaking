import Foundation

struct Item: Identifiable, Hashable {
    static let dates = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return formatter
    } () as DateFormatter
    
    static func spiegel(_ output: URLSession.DataTaskPublisher.Output) -> [Item] {
        String(decoding: output.0, as: UTF8.self).components(separatedBy: "<item>").dropFirst().compactMap {
            guard
                let id = content($0, tag: "guid"),
                let title = content($0, tag: "title"),
                let description = content($0, tag: "description"),
                let date = content($0, tag: "pubDate").flatMap ( { dates.date(from: $0) } )
            else { return nil }
            return Item(id, title, description, date)
        }
    }
    
    private static func content(_ string: String, tag: String) -> String? {
        string.components(separatedBy: "<" + tag + ">").last?.components(separatedBy: "</" + tag + ">").first
    }
    
    let id: String
    let title: String
    let description: String
    let date: Date
    
    private init(_ id: String, _ title: String, _ description: String, _ date: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
    }
    
    func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
