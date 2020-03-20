import Foundation

struct Item: Codable, Identifiable {
    var favourite = false
    var status = Status.new
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
}
