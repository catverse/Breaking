import SwiftUI

struct Empty: View {
    var body: some View {
        VStack {
            HStack {
                Text("this")
                    .foregroundColor(.secondary)
                    .font(Font.caption.bold())
                Spacer()
            }
            HStack {
                Text("Loading")
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
    }
}
