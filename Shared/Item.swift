import Foundation

struct Item: Codable, Identifiable, Hashable {
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
                let date = content($0, tag: "pubDate").flatMap ( { dates.date(from: $0) } ),
                let link = content($0, tag: "link").flatMap ( { URL(string: $0) } )
            else { return nil }
            return Item(.spiegel, id, title, description, date, link)
        }
    }
    
    private static func content(_ string: String, tag: String) -> String? {
        string.components(separatedBy: "<" + tag + ">").last?.components(separatedBy: "</" + tag + ">").first
    }
    
    var new = true
    var favourite = false
    let provider: Provider
    let id: String
    let title: String
    let description: String
    let date: Date
    let link: URL
    
    private init(_ provider: Provider, _ id: String, _ title: String, _ description: String, _ date: Date, _ link: URL) {
        self.provider = provider
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.link = link
    }
    
    func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
