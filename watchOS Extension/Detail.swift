import SwiftUI

struct Detail: View {
    @Binding var item: Item
    var close: () -> Void
    @State private var when = ""
    
    var body: some View {
        ScrollView {
            HStack {
                Text(.init(.key("Provider.\(item.provider)")))
                    .font(Font.footnote.bold())
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack {
                Text(when)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.bottom, 20)
            HStack {
                Text(item.title)
                    .font(.body)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }.padding(.bottom, 20)
            HStack {
                Text(item.description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            HStack {
                Spacer()
                Button(action: {
                    self.item.favourite.toggle()
                    news.balam.update(self.item)
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(item.favourite ? .init("lightning") : .secondary)
                }.frame(width: 60, height: 60)
                Spacer()
            }
        }.onAppear {
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
