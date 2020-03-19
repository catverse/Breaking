import SwiftUI

struct Articles: View {
    @ObservedObject var observable: Observable
    
    var body: some View {
        NavigationView {
            Group {
                if observable.articles.isEmpty {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                } else {
                    List(observable.articles) {
                        Article(item: $0)
                    }.listStyle(GroupedListStyle())
                }
            }.navigationBarTitle(.init("App.title"), displayMode: .large)
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
