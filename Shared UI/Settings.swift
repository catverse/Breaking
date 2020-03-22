import SwiftUI
import Combine

struct Settings: View {
    @State private var refresh = news.preferences.refresh
    @State private var hide = news.preferences.hide
    @State private var guardian = news.preferences.providers.contains(.guardian)
    @State private var spiegel = news.preferences.providers.contains(.spiegel)
    @State private var theLocal = news.preferences.providers.contains(.theLocal)
    @State private var favourites = news.preferences.favourites
    
    var body: some View {
        List {
            Section(header: Text("Settings.reload")) {
                Picker(selection: $refresh, label: Text("Settings.reload")) {
                        Text("Reload.5").tag(5)
                        Text("Reload.15").tag(15)
                        Text("Reload.30").tag(30)
                        Text("Reload.60").tag(60)
                    }.pickerStyle(SegmentedPickerStyle())
                }
            Section(header: Text("Settings.hide")) {
                VStack {
                    Picker(selection: $hide, label: Text("Settings.hide")) {
                        Text("Hide.7").tag(7)
                        Text("Hide.30").tag(30)
                        Text("Hide.365").tag(365)
                    }.pickerStyle(SegmentedPickerStyle())
                    HStack {
                        Text("Settings.still")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
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
            Section {
                Toggle(isOn: $favourites) {
                    Text("Settings.favourites")
                        .bold()
                        .foregroundColor(favourites ? .primary : .secondary)
                }
            }
        }.listStyle(GroupedListStyle())
            .navigationBarTitle(.init("Settings.title"), displayMode: .inline)
        .onReceive(Just(refresh)) {
            news.preferences.refresh = $0
            news.balam.update(news.preferences)
        }.onReceive(Just(hide)) {
            news.preferences.hide = $0
            news.balam.update(news.preferences)
        }.onReceive(Just(guardian)) {
            news.preferences.providers.removeAll { $0 == .guardian }
            if $0 {
                news.preferences.providers.append(.guardian)
            }
            news.balam.update(news.preferences)
        }.onReceive(Just(spiegel)) {
            news.preferences.providers.removeAll { $0 == .spiegel }
            if $0 {
                news.preferences.providers.append(.spiegel)
            }
            news.balam.update(news.preferences)
        }.onReceive(Just(theLocal)) {
            news.preferences.providers.removeAll { $0 == .theLocal }
            if $0 {
                news.preferences.providers.append(.theLocal)
            }
            news.balam.update(news.preferences)
        }.onReceive(Just(favourites)) {
            news.preferences.favourites = $0
            news.balam.update(news.preferences)
        }.onDisappear {
            news.reload()
        }
    }
}
