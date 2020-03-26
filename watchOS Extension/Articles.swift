import SwiftUI

final class Articles: WKHostingController<AnyView> {
    override var body: AnyView { .init(Content()) }
}

private struct Content: View {
    var body: some View {
        Text("Hello, World!")
    }
}
