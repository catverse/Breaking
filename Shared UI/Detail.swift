import SwiftUI

struct Detail: View {
    let item: Item
    var close: () -> Void
    @State private var when = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Text(item.title)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding(.init(top: 20, leading: 20, bottom: 10, trailing: 20))
                HStack {
                    Text(item.description)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding(.horizontal, 20)
                }.navigationBarItems(leading: Button(action: close) {
                    Image(systemName: "xmark")
                        .accentColor(.secondary)
                }, trailing: Text(when)).navigationBarTitle(.init(.key("Provider.\(item.provider)")), displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
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
