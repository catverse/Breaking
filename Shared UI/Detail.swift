import SwiftUI

struct Detail: View {
    let item: Item
    
    var body: some View {
        NavigationView {
            List {
                Circle()
//                Section {
//                    if items.isEmpty {
//                        Empty()
//                    }
//                }
//                Section(header: Text(items.isEmpty
//                    ? ""
//                    : .init(formatter.string(from: .init(value: items.count))! + .key("Counter")))) {
//                    ForEach(items) { item in
//                        Article(item: item).onTapGesture {
//                            self.selected = item
//                        }
//                    }
//                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle(.init("App.title"), displayMode: .large)
        }
    }
}
