import Foundation
import Combine

final class News {
    private var sub: AnyCancellable?
    private let spiegel = URL(string: "https://www.spiegel.de/international/index.rss")!
    
    func refresh() {
        sub = URLSession.shared.dataTaskPublisher(for: spiegel).map(parse(_:)).replaceError(with: []).sink {
            print($0)
        }
    }
    
    private func parse(_ output: URLSession.DataTaskPublisher.Output) -> [String] {
        []
    }
}
