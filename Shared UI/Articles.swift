import SwiftUI

struct Articles: View {
    let news: News
    @State private var items = [Item]()
    private let formatter = NumberFormatter()
    
    var body: some View {
        NavigationView {
            Group {
                if items.isEmpty {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                } else {
                    List {
                        Section(header: Text(.init(formatter.string(from: .init(value: items.count))! + .key("Counter")))) {
                            ForEach(items) {
                                Article(item: $0)
                            }
                        }
                    }.listStyle(GroupedListStyle())
                }
            }.navigationBarTitle(.init("App.title"), displayMode: .large)
        }
        .onReceive(news) {
            self.items = $0
        }
    }
}

private struct Article: View {
    let item: Item
    @State private var when = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(when)
                    .foregroundColor(.secondary)
                    .font(Font.caption.bold())
                Spacer()
            }
            HStack {
                Text(item.title)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            HStack {
                Text(item.description)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                Spacer()
            }
        }.onAppear {
            self.when = self.item.date > Calendar.current.date(byAdding: .hour, value: -13, to: self.item.date)!
                ? RelativeDateTimeFormatter().localizedString(for: self.item.date, relativeTo: .init())
                : {
                    $0.dateStyle = .full
                    $0.timeStyle = .short
                    return $0.string(from: self.item.date)
            } (DateFormatter())
        }
    }
}
