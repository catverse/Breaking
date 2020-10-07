import SwiftUI

struct Articles: View {
    @State private var items = [Item]()
    @State private var selected: Item!
    @State private var detail = false
    private let formatter = NumberFormatter()
    
    var body: some View {
        NavigationView {
            List {
                if items.isEmpty {
                    Section {
                        Empty()
                        Empty()
                        Empty()
                    }
                }
                Section(header: Text(items.isEmpty
                    ? ""
                    : .init(formatter.string(from: .init(value: items.count))! + .key("Counter")))) {
                    ForEach(items) { item in
                        Article(item: item) {
                            self.selected = item
                            self.detail = true
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle(.init("App.title"), displayMode: .large)
                .navigationBarItems(trailing:
                    NavigationLink(destination: Settings()) {
                        Image(systemName: "slider.horizontal.3")
                            .accentColor(.init("lightning"))
                    }.frame(width: 100, height: 100, alignment: .trailing))
        }.navigationViewStyle(StackNavigationViewStyle())
            .onReceive(news) {
            self.items = $0
        }.sheet(isPresented: $detail) {
            Detail(item: $selected) {
                self.detail = false
            }
        }
    }
}
