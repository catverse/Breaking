import SwiftUI

struct Article: View {
    @State var item: Item
    let select: (Item) -> Void
    @State private var when = ""
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.item.status = .read
            }
            balam.update(self.item)
            self.select(self.item)
        }) {
            VStack {
                HStack {
                    Text(.init(.key("Provider.\(item.provider)")))
                        .foregroundColor(.primary)
                        .font(.caption)
                    Spacer()
                    Text(when)
                        .foregroundColor(.secondary)
                        .font(.caption)
                }.padding(.bottom, 10)
                HStack {
                    if item.status == .new {
                        Image(systemName: "plus")
                            .foregroundColor(.primary)
                    }
                    Text(item.title)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if item.favourite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }.accentColor(.accentColor)
            .background(Color.clear)
            .padding(.vertical, 10)
            .opacity(item.status == .read ? 0.4 : 1)
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
