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
            }.navigationBarTitle(.init(.key("Provider.\(item.provider)")), displayMode: .inline)
                .navigationBarItems(leading: Button(action: close) {
                    Image(systemName: "xmark")
                        .accentColor(.secondary)
                }, trailing: Text(when))
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
