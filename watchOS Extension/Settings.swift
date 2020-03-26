import SwiftUI
import Combine

struct Settings: View {
    @State private var refresh = news.preferences.refresh
    @State private var hide = news.preferences.hide
    @State private var guardian = news.preferences.providers.contains(.guardian)
    @State private var spiegel = news.preferences.providers.contains(.spiegel)
    @State private var theLocal = news.preferences.providers.contains(.theLocal)
    @State private var filter = news.preferences.filter
    
    var body: some View {
        List {
            Section(header: Text("Settings.filter")) {
                Picker(selection: $filter, label: Text("Settings.filter")) {
                    Text("Filter.all").tag(Filter.all)
                    Text("Filter.unread").tag(Filter.unread)
                    Text("Filter.favourites").tag(Filter.favourites)
                }
            }
            Section(header: Text("Settings.reload")) {
                Picker(selection: $refresh, label: Text("Settings.reload")) {
                    Text("Reload.5").tag(5)
                    Text("Reload.15").tag(15)
                    Text("Reload.30").tag(30)
                    Text("Reload.60").tag(60)
                }
            }
            Section(header: Text("Settings.hide")) {
                Picker(selection: $hide, label: Text("Settings.hide")) {
                    Text("Hide.7").tag(7)
                    Text("Hide.30").tag(30)
                    Text("Hide.365").tag(365)
                }
            }
            Section(header: Text("Settings.providers")) {
                Toggle(isOn: $guardian) {
                    Text("Provider.guardian")
                        .bold()
                        .foregroundColor(guardian ? .primary : .secondary)
                }
                Toggle(isOn: $spiegel) {
                    Text("Provider.spiegel")
                        .bold()
                        .foregroundColor(spiegel ? .primary : .secondary)
                }
                Toggle(isOn: $theLocal) {
                    Text("Provider.theLocal")
                        .bold()
                        .foregroundColor(theLocal ? .primary : .secondary)
                }
            }
        }.navigationBarTitle(.init("Settings.title"))
            .onReceive(Just(filter)) {
                news.preferences.filter = $0
                news.save()
            }
        .onReceive(Just(refresh)) {
            news.preferences.refresh = $0
            news.save()
        }.onReceive(Just(hide)) {
            news.preferences.hide = $0
            news.save()
        }.onReceive(Just(guardian)) {
            news.preferences.providers.removeAll { $0 == .guardian }
            if $0 {
                news.preferences.providers.append(.guardian)
            }
            news.save()
        }.onReceive(Just(spiegel)) {
            news.preferences.providers.removeAll { $0 == .spiegel }
            if $0 {
                news.preferences.providers.append(.spiegel)
            }
            news.save()
        }.onReceive(Just(theLocal)) {
            news.preferences.providers.removeAll { $0 == .theLocal }
            if $0 {
                news.preferences.providers.append(.theLocal)
            }
            news.save()
        }.onDisappear {
            news.reload()
        }
    }
}
