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
                        Button(action: {
                            var item = item
                            item.status = .read
                            balam.update(item)
                            self.selected = item
                        }) {
                            Article(item: item)
                        }.accentColor(.accentColor)
                            .background(Color.clear)
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle(.init("App.title"), displayMode: .large)
        }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(item: $selected) {
                Detail(item: $0) {
                    self.selected = nil
                }
        }.onReceive(news) {
            self.items = $0
        }
    }
}
