import SwiftUI

struct Detail: View {
    @Binding var item: Item!
    var close: () -> Void
    @State private var when = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Text(item.title)
                        .font(.title)
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
                        self.item.favourite.toggle()
                        news.balam.update(self.item)
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(item.favourite ? .init("lightning") : .secondary)
                    }.frame(width: 80, height: 80)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        UIApplication.shared.open(self.item.link)
                    }) {
                        Text("More")
                    }.frame(width: 180, height: 42)
                        .font(Font.footnote.bold())
                        .foregroundColor(.black)
                        .background(Color("lightning"))
                        .cornerRadius(6)
                    Spacer()
                }.padding(.bottom, 40)
            }.navigationBarItems(leading:
                HStack {
                    Text(.init(.key("Provider.\(item.provider)") + ": " + when))
                        .font(.caption)
                        .foregroundColor(.secondary)
                },
                                 trailing:
                Button(action: close) {
                    Image(systemName: "xmark")
                        .accentColor(.secondary)
                }.frame(width: 120, height: 80, alignment: .trailing))
            .navigationBarTitle("", displayMode: .inline)
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
