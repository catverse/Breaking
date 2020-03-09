import Balam
import Foundation
import Combine

final class News {
    @Published private(set) var items = Set<Item>()
    private var graph: Graph!
    private var subs = Set<AnyCancellable>()
    private let spiegel = URL(string: "https://www.spiegel.de/international/index.rss")!
    private let reddit = URL(string: "https://www.reddit.com/r/worldnews/.rss")!
    private let thelocal = URL(string: "https://feeds.thelocal.com/rss/de")!
    private let formatter = DateFormatter()
 
    init() {
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        Balam.graph("Breaking").sink {
            self.graph = $0
            self.fetch()
        }.store(in: &subs)
    }
    
    func refresh() {
        URLSession.shared.dataTaskPublisher(for: reddit).map { self.parse($0, provider: .spiegel) }.replaceError(with: []).sink {
            self.merge($0)
        }.store(in: &subs)
    }
    
    func read(_ item: Item) {
        var item = item
        item.new = false
        graph.update(item)
    }
    
    private func merge(_ new: [Item]) {
        new.forEach {
            if !items.contains($0) {
                graph.add($0)
            }
        }
        fetch()
    }
    
    private func fetch() {
        graph.nodes(Item.self).sink {
            self.items = .init($0)
        }.store(in: &subs)
    }
    
    private func parse(_ output: URLSession.DataTaskPublisher.Output, provider: Provider) -> [Item] {
        String(decoding: output.0, as: UTF8.self).components(separatedBy: "<item").dropFirst().compactMap {
            guard
                let id = content($0, tag: "guid"),
                let title = content($0, tag: "title"),
                let description = content($0, tag: "description"),
                let date = content($0, tag: "pubDate").flatMap ( { formatter.date(from: $0) } ),
                let link = content($0, tag: "link").flatMap ( { URL(string: $0) } )
            else { return nil }
            return Item(.spiegel, id, title, description, date, link)
        }
    }
    
    private func content(_ string: String, tag: String) -> String? {
        string.components(separatedBy: "<" + tag).last?.components(separatedBy: ">").dropFirst().first?.components(separatedBy: "</" + tag + ">").first
    }
}
