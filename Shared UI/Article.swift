import SwiftUI

struct Article: View {
    @State var item: Item
    let select: (Article) -> Void
    @State private var when = ""
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.item.status = .read
            }
            news.balam.update(self.item)
            self.select(self)
        }) {
            VStack {
                HStack {
                    Text(.init(.key("Provider.\(item.provider)")))
                        .foregroundColor(.primary)
                        .font(.caption)
                        .opacity(item.status == .read ? 0.3 : 1)
                    Spacer()
                    Text(when)
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .opacity(item.status == .read ? 0.6 : 1)
                }.padding(.bottom, 10)
                HStack {
                    if item.status == .new {
                        Image(systemName: "plus")
                            .foregroundColor(.primary)
                    }
                    Text(item.title)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .opacity(item.status == .read ? 0.3 : 1)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if item.favourite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.init("lightning"))
                    }
                }
            }
        }.accentColor(.accentColor)
            .background(Color.clear)
            .padding(.vertical, 10)
            .onAppear {
                self.when = self.item.date > Calendar.current.date(byAdding: .hour, value: -23, to: .init())!
                ? RelativeDateTimeFormatter().localizedString(for: self.item.date, relativeTo: .init())
                : {
                    $0.dateStyle = .full
                    $0.timeStyle = .none
                    return $0.string(from: self.item.date)
            } (DateFormatter())
        }
    }
}
