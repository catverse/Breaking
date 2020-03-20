import SwiftUI

struct Articles: View {
    let news: News
    @State private var items = [Item]()
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
                    ForEach(items) {
                        Article(item: $0)
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle(.init("App.title"), displayMode: .large)
        }
        .onReceive(news) {
            self.items = $0
        }
    }
}

private struct Empty: View {
    var body: some View {
        VStack {
            HStack {
                Text("this")
                    .foregroundColor(.secondary)
                    .font(Font.caption.bold())
                Spacer()
            }
            HStack {
                Text("Loading")
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
    }
}

private struct Article: View {
    let item: Item
    @State private var when = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(.init(.key("Provider.\(item.provider)")))
                    .foregroundColor(.accentColor)
                    .font(.caption)
                Spacer()
                Text(when)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }.padding(.bottom, 10)
            HStack {
                Text(item.title)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }.padding(.vertical, 10)
            .onAppear {
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
