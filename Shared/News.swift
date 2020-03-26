import Balam
import Foundation
import Combine

let news = News()

final class News: Publisher {
    typealias Output = [Item]
    typealias Failure = Never
    
    var preferences = Preferences()
    let balam = Balam("Breaking")
    private var cancellables = Set<AnyCancellable>()
    private var last = Date.distantPast
    private let sub = Sub()
    private let formatter = DateFormatter()
    private let url = [Provider.guardian : URL(string: "https://www.theguardian.com/world/rss")!,
                       .spiegel : URL(string: "https://www.spiegel.de/international/index.rss")!,
                       .theLocal : URL(string: "https://feeds.thelocal.com/rss/de")!]
    private let characters = [
        "&quot;" : "\"",
        "&amp;" : "&",
        "amp;" : "",
        "&apos;" : "'",
        "&lt;" : "<",
        "&gt;" : ">",
        "&#039;" : "'",
        "  " : " ",
        "&nbsp;" : "",
        "\r" : " ",
        "\n" : " ",
    ]

    fileprivate init() {
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        balam.nodes(Preferences.self).sink {
            if let loaded = $0.first {
                self.preferences = loaded
            } else {
                self.balam.add(self.preferences)
            }
        }.store(in: &cancellables)
    }
    
    func refresh() {
        if Calendar.current.date(byAdding: .minute, value: preferences.refresh, to: last)! < .init() {
            last = .init()
            request([.guardian, .spiegel, .theLocal])
        }
    }
    
    func reload() {
        balam.nodes(Item.self).sink {
            let older = Calendar.current.date(byAdding: .day, value: -self.preferences.hide, to: .init())!
            let items = $0
                .filter { self.preferences.providers.contains($0.provider) }
                .filter { $0.date > older }
                .filter {
                    switch(self.preferences.filter) {
                    case .favourites: return $0.favourite
                    case .unread: return $0.status != .read
                    default: return true
                    }
                }
                .sorted { $0.date > $1.date }
            DispatchQueue.main.async {
                _ = self.sub.subscriber?.receive(items)
            }
        }.store(in: &cancellables)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        sub.subscriber = .init(subscriber)
        subscriber.receive(subscription: sub)
    }
    
    func save() {
        balam.update(preferences)
    }
    
    private func request(_ providers: [Provider]) {
        guard let provider = providers.first else {
            fetch()
            return
        }
        URLSession.shared.dataTaskPublisher(for: url[provider]!).map { self.parse($0, provider: provider) }.replaceError(with: []).sink {
            self.balam.add($0)
            self.request(.init(providers.dropFirst()))
        }.store(in: &cancellables)
    }
    
    private func fetch() {
        let limit = Calendar.current.date(byAdding: .hour, value: -3, to: .init())!
        balam.update(Item.self) {
            if $0.status == .new && $0.downloaded < limit {
                $0.status = .waiting
            }
        }
        reload()
    }
    
    private func parse(_ output: URLSession.DataTaskPublisher.Output, provider: Provider) -> [Item] {
        String(decoding: output.0, as: UTF8.self).components(separatedBy: "<item").dropFirst().compactMap {
            guard
                let id = content($0, tag: "guid"),
                let title = content($0, tag: "title").flatMap( { clean($0) }),
                let description = content($0, tag: "description").flatMap( { strip(clean($0)) } ),
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
        var cleaned = characters.reduce(string) {
            $0.replacingOccurrences(of: $1.0, with: $1.1)
        }
        while cleaned.contains("  ") {
            cleaned = cleaned.replacingOccurrences(of: "  ", with: " ")
        }
        return cleaned
    }
    
    private func strip(_ string: String) -> String {
        string.contains("<p")
            ? string.components(separatedBy: "<p>").dropFirst().reduce(into: "") {
                $0 += $0.isEmpty ? "" : "\n\n"
                $0 += $1.components(separatedBy: "</p>").first!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
                if !$0.hasSuffix(".") && !$0.hasSuffix(". ") && !$0.hasSuffix("?") && !$0.hasSuffix("\n") {
                    $0 += "."
                }
            }
            : string
    }
    
    private final class Sub: Subscription {
        var subscriber: AnySubscriber<Output, Failure>?
        func request(_ demand: Subscribers.Demand) { }
        func cancel() { subscriber = nil }
    }
}
