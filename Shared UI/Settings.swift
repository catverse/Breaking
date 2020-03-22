import SwiftUI
import Combine

struct Settings: View {
    @State private var refresh = preferences.refresh
    @State private var hide = preferences.hide
    @State private var guardian = preferences.providers.contains(.guardian)
    @State private var spiegel = preferences.providers.contains(.spiegel)
    @State private var theLocal = preferences.providers.contains(.theLocal)
    @State private var favourites = preferences.favourites
    
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
            preferences.refresh = $0
            balam.update(preferences)
        }.onReceive(Just(hide)) {
            preferences.hide = $0
            balam.update(preferences)
        }.onReceive(Just(guardian)) {
            preferences.providers.removeAll { $0 == .guardian }
            if $0 {
                preferences.providers.append(.guardian)
            }
            balam.update(preferences)
        }.onReceive(Just(spiegel)) {
            preferences.providers.removeAll { $0 == .spiegel }
            if $0 {
                preferences.providers.append(.spiegel)
            }
            balam.update(preferences)
        }.onReceive(Just(theLocal)) {
            preferences.providers.removeAll { $0 == .theLocal }
            if $0 {
                preferences.providers.append(.theLocal)
            }
            balam.update(preferences)
        }.onReceive(Just(favourites)) {
            preferences.favourites = $0
            balam.update(preferences)
        }
    }
}
