import SwiftUI

struct Description: View {
    @Binding var item: Item!
    @State private var when = ""
    
    var body: some View {
        ScrollView {
            HStack {
                Text(.init(.key("Provider.\(item.provider)") + ": " + when))
                    .foregroundColor(.secondary)
                Spacer()
            }.padding()
            HStack {
                Text(item.description)
                    .font(.title)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }.padding()
            HStack {
                Spacer()
                Button(action: {
                    self.item.favourite.toggle()
                    news.balam.update(self.item!)
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
        }.navigationBarTitle(item.title)
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
