import Balam
import Foundation
import Combine

final class News {
    @Published private(set) var items = Set<Item>()
    private var graph: Graph!
    private var subs = Set<AnyCancellable>()
    private let spiegel = URL(string: "https://www.spiegel.de/international/index.rss")!
 
    init() {
        Balam.graph("Breaking").sink {
            self.graph = $0
            self.fetch()
        }.store(in: &subs)
    }
    
    func refresh() {
        URLSession.shared.dataTaskPublisher(for: spiegel).map(Item.spiegel(_:)).replaceError(with: []).sink {
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
}
