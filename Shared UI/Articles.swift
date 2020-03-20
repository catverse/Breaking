import SwiftUI

struct Articles: View {
    let news: News
    @State private var items = [Item]()
    @State private var selected: Item?
    private let formatter = NumberFormatter()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    if items.isEmpty {
                        Empty()
                    }
                }
                Section(header: Text(items.isEmpty
                    ? ""
                    : .init(formatter.string(from: .init(value: items.count))! + .key("Counter")))) {
                    ForEach(items) { item in
                        Article(item: item).onTapGesture {
                            self.selected = item
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle(.init("App.title"), displayMode: .large)
        }.sheet(item: $selected) {
            Detail(item: $0)
        }.onReceive(news) {
            self.items = $0
        }
    }
}
