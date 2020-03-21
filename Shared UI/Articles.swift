import SwiftUI

struct Articles: View {
    let news: News
    @State private var items = [Item]()
    @State private var selected: Article?
    @State private var detail = false
    @State private var settings = false
    private let formatter = NumberFormatter()
    
    var body: some View {
        NavigationView {
            List {
                if items.isEmpty {
                    Section {
                        Empty()
                    }
                }
                if settings {
                    Settings()
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
                .navigationBarItems(trailing:
                    Button(action: {
                        self.settings.toggle()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .accentColor(settings ? .init("lightning") : .secondary)
                }.frame(width: 120, height: 80, alignment: .trailing))
        }.navigationViewStyle(StackNavigationViewStyle())
            .onReceive(news) {
            self.items = $0
        }.sheet(isPresented: $detail) {
                Detail(item: self.selected!.$item) {
                    self.detail = false
                }
        }
    }
}
