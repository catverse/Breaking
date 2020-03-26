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
                        .font(.footnote)
                        .opacity(item.status == .read ? 0.3 : 1)
                    Spacer()
                }
                HStack {
                    Text(when)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .opacity(item.status == .read ? 0.6 : 1)
                    Spacer()
                }
                if item.status == .new {
                    HStack {
                        if item.status == .new {
                            Image(systemName: "plus")
                                .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                }
                HStack {
                    Text(item.title)
                        .font(.footnote)
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
            .padding(.init(top: 12, leading: 0, bottom: 6, trailing: 0))
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
