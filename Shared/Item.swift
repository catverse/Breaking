import Foundation

struct Item: Codable, Equatable, Hashable {
    var status = Status.new
    var favourite = false
    let provider: Provider
    let id: String
    let title: String
    let description: String
    let date: Date
    let link: URL
    let downloaded: Date
    
    init(_ provider: Provider, _ id: String, _ title: String, _ description: String, _ date: Date, _ link: URL) {
        self.provider = provider
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.link = link
        self.downloaded = .init()
    }
    
    func hash(into: inout Hasher) {
        into.combine(id)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
}
