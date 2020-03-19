import SwiftUI

struct Articles: View {
    let news: News
    @State private var items = [Item]()
    private let formatter = NumberFormatter()
    //counter.stringValue =
    var body: some View {
        NavigationView {
            Group {
                if items.isEmpty {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                } else {
                    List(items) {
                        Article(item: $0)
                    }.listStyle(GroupedListStyle())
                }
            }.navigationBarTitle(.init(formatter.string(from: .init(value: items.count))! + .key("Counter")), displayMode: .large)
        }
        .onReceive(news) {
            self.items = $0.sorted { $0.date > $1.date }
        }
    }
}

private struct Article: View {
    let item: Item
    
    var body: some View {
        VStack {
            HStack {
                Text(item.title)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
    }
}
