import Balam
import Foundation
import Combine

final class News: Publisher {
    typealias Output = Set<Item>
    typealias Failure = Never
    private(set) var graph: Graph!
    private var cancellables = Set<AnyCancellable>()
    private let sub = Sub()
    private let formatter = DateFormatter()
    private let url = [Provider.spiegel : URL(string: "https://www.spiegel.de/international/index.rss")!,
                       .theLocal : URL(string: "https://feeds.thelocal.com/rss/de")!]
    private let characters = [
        "&quot;" : "\"",
        "&amp;" : "&",
        "&apos;" : "'",
        "&lt;" : "<",
        "&gt;" : ">",
        "&#039;" : "'"
    ]

    init() {
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
    }
    
    func refresh() {
        if graph == nil {
            Balam.graph("Breaking").sink {
                self.graph = $0
                self.fetch()
                self.request()
            }.store(in: &cancellables)
        } else {
            request()
        }
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        sub.subscriber = .init(subscriber)
        subscriber.receive(subscription: sub)
    }
    
    private func request(_ providers: [Provider] = [.spiegel, .theLocal]) {
        guard let provider = providers.first else {
            fetch()
            return
        }
        URLSession.shared.dataTaskPublisher(for: url[provider]!).map { self.parse($0, provider: provider) }.replaceError(with: []).sink {
            self.graph.add($0)
            self.request(.init(providers.dropFirst()))
        }.store(in: &cancellables)
    }
    
    private func fetch() {
        graph.nodes(Item.self).sink {
            _ = self.sub.subscriber?.receive(.init($0))
        }.store(in: &cancellables)
    }
    
    private func parse(_ output: URLSession.DataTaskPublisher.Output, provider: Provider) -> [Item] {
        String(decoding: output.0, as: UTF8.self).components(separatedBy: "<item").dropFirst().compactMap {
            guard
                let id = content($0, tag: "guid"),
                let title = content($0, tag: "title").flatMap( { clean($0) }),
                let description = content($0, tag: "description").flatMap( { clean($0) } ),
                let date = content($0, tag: "pubDate").flatMap( { formatter.date(from: $0) } ),
                let link = content($0, tag: "link").flatMap( { URL(string: $0) } )
            else { return nil }
            return Item(provider, id, title, description, date, link)
        }
    }
    
    private func content(_ string: String, tag: String) -> String? {
        string.components(separatedBy: "<" + tag).last?.components(separatedBy: ">").dropFirst().first?.components(separatedBy: "</" + tag).first
    }
    
    private func clean(_ string: String) -> String {
        characters.reduce(string) {
            $0.replacingOccurrences(of: $1.0, with: $1.1)
        }
    }
    
    private final class Sub: Subscription {
        var subscriber: AnySubscriber<Output, Failure>?
        func request(_ demand: Subscribers.Demand) { }
        func cancel() { subscriber = nil }
    }
}
