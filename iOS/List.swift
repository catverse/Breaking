import SwiftUI

struct List: View {
    var body: some View {
        NavigationView {
            Circle()
                .navigationBarTitle(.init("Title"), displayMode: .large)
        }
    }
}
