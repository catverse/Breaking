import SwiftUI

struct Articles: View {
    let news: News
    @State private var items = [Item]()
    
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
            }.navigationBarTitle(.init("App.title"), displayMode: .large)
        }.onReceive(news) {
            assert(Thread.main == .current)
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
