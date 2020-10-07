import SwiftUI

final class Articles: WKHostingController<AnyView> {
    override var body: AnyView { .init(Content()) }
}

private struct Content: View {
    @State private var items = [Item]()
    @State private var selected: Item!
    @State private var detail = false
    private let formatter = NumberFormatter()
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: Settings()) {
                    HStack {
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.init("lightning"))
                    }
                }.listRowBackground(Color.clear)
            }
            if items.isEmpty {
                Section {
                    Empty()
                        .listRowBackground(Color.clear)
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
        }.navigationBarTitle(.init("App.title"))
            .onReceive(news) {
                self.items = $0
        }.sheet(isPresented: $detail) {
            Detail(item: $selected) {
                self.detail = false
            }
        }
    }
}
