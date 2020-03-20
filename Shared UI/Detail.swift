import SwiftUI

struct Detail: View {
    let item: Item
    var close: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text(.init(.key("Provider.\(item.provider)")))
                            .foregroundColor(.accentColor)
                            .font(.footnote)
                        Spacer()
    //                    Text(when)
    //                        .foregroundColor(.secondary)
    //                        .font(.caption)
                    }.padding(.bottom, 10)
                    HStack {
                        Text(item.title)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    HStack {
                        Text(item.description)
                            .foregroundColor(.secondary)
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
            }.navigationBarItems(leading: Button(action: close) {
                Image(systemName: "xmark")
                    .accentColor(.secondary)
            })
        }
    }
}
