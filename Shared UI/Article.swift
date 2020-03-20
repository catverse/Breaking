import SwiftUI

struct Article: View {
    let item: Item
    @State private var when = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(.init(.key("Provider.\(item.provider)")))
                    .foregroundColor(.accentColor)
                    .font(.footnote)
                Spacer()
                Text(when)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }.padding(.bottom, 10)
            HStack {
                if item.status == .new {
                    Image(systemName: "plus")
                }
                Text(item.title)
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
