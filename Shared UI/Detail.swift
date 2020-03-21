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
                }.padding()
                HStack {
                    Text(item.description)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding()
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("More")
                    }.frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(6)
                        .padding()
                    Spacer()
                }
            }.navigationBarItems(leading:
                HStack {
                    Text(.init(.key("Provider.\(item.provider)")))
                        .font(Font.footnote.bold())
                        .foregroundColor(.secondary)
                    Text(when).font(.footnote)
                        .foregroundColor(.secondary)
                },
                                 trailing:
                Button(action: close) {
                    Image(systemName: "xmark")
                        .accentColor(.secondary)
                }.frame(width: 120, height: 65, alignment: .trailing))
        }.navigationViewStyle(StackNavigationViewStyle())
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
