import Foundation
import Combine

final class News {
    @Published private(set) var items = [Item]()
    private var sub: AnyCancellable?
    private let spiegel = URL(string: "https://www.spiegel.de/international/index.rss")!
    
    func refresh() {
        sub = URLSession.shared.dataTaskPublisher(for: spiegel).map(parse(_:)).replaceError(with: []).sink {
            self.items.append(contentsOf: $0)
        }
    }
    
    private func parse(_ output: URLSession.DataTaskPublisher.Output) -> [Item] {
        String(decoding: output.0, as: UTF8.self).components(separatedBy: "<item>").dropFirst().map {
            var item = Item()
            $0.components(separatedBy: "<title>").last.map { item.title = $0.components(separatedBy: "</title>").first! }
//            item.info = $0.components(separatedBy: "</item>").first!
            return item
        }
    }
}
/*
 
 
Breaking.Item(title: "", info: "\n<title>Kenya: Changing Minds About Female Circumcision</title>\n<link>https://www.spiegel.de/international/world/kenya-changing-minds-about-female-circumcision-a-40eef55f-0598-4dd3-be42-9e5d1fcd435f#ref=rss</link>\n<description>Kenya banned female genital mutilation years ago, but the bloody practice lives on in many rural communities. One NGO is going village to village to sell tribal elders on alternative traditions. And it\'s working.</description>\n<enclosure type=\"image/jpeg\" url=\"https://cdn.prod.www.spiegel.de/images/446a4fca-909e-4110-aac2-cda25366c5f1_w520_r2.08_fpx57.33_fpy50.jpg\"/>\n<guid>https://www.spiegel.de/international/world/kenya-changing-minds-about-female-circumcision-a-40eef55f-0598-4dd3-be42-9e5d1fcd435f</guid>\n<pubDate>Thu, 5 Mar 2020 16:43:19 +0100</pubDate>\n<content:encoded>Kenya banned female genital mutilation years ago, but the bloody practice lives on in many rural communities. One NGO is going village to village to sell tribal elders on alternative traditions. And it\'s working.</content:encoded>\n</item>\n")

 */
