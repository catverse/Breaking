import SwiftUI

struct Split: View {
    @State private var items = [Item]()
    @State private var selected: Item!
    
    var body: some View {
        NavigationView {
            Listed(items: $items, selected: $selected)
            if selected == nil {
                Text("Select an article")
                    .foregroundColor(.secondary)
            } else {
                Description(item: $selected)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .onReceive(news) {
            self.items = $0
        }
    }
}

private struct Listed: View {
    @Binding var items: [Item]
    @Binding var selected: Item!
    private let formatter = NumberFormatter()
    
    var body: some View {
        List {
            if items.isEmpty {
                Section {
                    Empty()
                    Empty()
                    Empty()
                    Empty()
                    Empty()
                    Empty()
                }.frame(maxWidth: 200)
            }
            Section(header: Text(items.isEmpty
                ? ""
                : .init(formatter.string(from: .init(value: items.count))! + .key("Counter")))) {
                ForEach(items) { item in
                    Article(item: item) {
                        var item = item
                        withAnimation {
                            item.status = .read
                            selected = item
                        }
                        news.balam.update(item)
                    }.listRowBackground(item.id == self.selected?.id ? Color("lightning") : Color.clear)
                }
            }
        }.listStyle(GroupedListStyle())
            .navigationBarTitle(.init("App.title"), displayMode: .large)
            .navigationBarItems(trailing:
                NavigationLink(destination: Settings()) {
                    Image(systemName: "slider.horizontal.3")
                        .accentColor(.init("lightning"))
                }.frame(width: 100, height: 100, alignment: .trailing))
    }
}
