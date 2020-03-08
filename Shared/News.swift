import Foundation
import Combine

final class News {
    @Published private(set) var items = Set<Item>()
    private var sub: AnyCancellable?
    private let spiegel = URL(string: "https://www.spiegel.de/international/index.rss")!
    //feed:https://www.reddit.com/r/worldnews/.rss
    //https://feeds.thelocal.com/rss/de
    
    
    func refresh() {
        sub = URLSession.shared.dataTaskPublisher(for: spiegel).map(Item.spiegel(_:)).replaceError(with: []).sink {
            self.items = .init(self.items + $0)
        }
    }
}
/*
 
 
Breaking.Item(title: "", info: "\n<title>Kenya: Changing Minds About Female Circumcision</title>\n<link>https://www.spiegel.de/international/world/kenya-changing-minds-about-female-circumcision-a-40eef55f-0598-4dd3-be42-9e5d1fcd435f#ref=rss</link>\n<description>Kenya banned female genital mutilation years ago, but the bloody practice lives on in many rural communities. One NGO is going village to village to sell tribal elders on alternative traditions. And it\'s working.</description>\n<enclosure type=\"image/jpeg\" url=\"https://cdn.prod.www.spiegel.de/images/446a4fca-909e-4110-aac2-cda25366c5f1_w520_r2.08_fpx57.33_fpy50.jpg\"/>\n<guid>https://www.spiegel.de/international/world/kenya-changing-minds-about-female-circumcision-a-40eef55f-0598-4dd3-be42-9e5d1fcd435f</guid>\n<pubDate>Thu, 5 Mar 2020 16:43:19 +0100</pubDate>\n<content:encoded>Kenya banned female genital mutilation years ago, but the bloody practice lives on in many rural communities. One NGO is going village to village to sell tribal elders on alternative traditions. And it\'s working.</content:encoded>\n</item>\n")

 */
