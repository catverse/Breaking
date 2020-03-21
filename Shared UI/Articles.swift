import SwiftUI

struct Articles: View {
    let news: News
    @State private var items = [Item]()
    @State private var detail = false
    @State private var selected: Article?
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
                        Article(item: item) {
                            self.selected = $0
                            self.detail = true
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle(.init("App.title"), displayMode: .large)
        }.navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $detail) {
            Detail(item: self.selected!.$item) {
                self.detail = false
            }
        }.onReceive(news) {
            self.items = $0
        }
    }
}
