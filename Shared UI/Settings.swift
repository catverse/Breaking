import SwiftUI
import Combine

struct Settings: View {
    @State private var refresh = preferences.refresh
    @State private var guardian = preferences.providers.contains(.guardian)
    @State private var spiegel = preferences.providers.contains(.spiegel)
    @State private var theLocal = preferences.providers.contains(.theLocal)
    
    var body: some View {
        Group {
            Section(header: Text("Settings.reload")) {
                Picker(selection: $refresh, label: Text("Settings.reload")) {
                    Text("Reload.5").tag(5)
                    Text("Reload.15").tag(15)
                    Text("Reload.30").tag(30)
                    Text("Reload.60").tag(60)
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Settings.providers")) {
                Toggle(isOn: $guardian) {
                    Text("Provider.guardian")
                        .bold()
                        .foregroundColor(guardian ? .primary : .secondary)
                }.foregroundColor(.secondary)
                Toggle(isOn: $spiegel) {
                    Text("Provider.spiegel")
                        .bold()
                        .foregroundColor(spiegel ? .primary : .secondary)
                }.foregroundColor(.secondary)
                Toggle(isOn: $theLocal) {
                    Text("Provider.theLocal")
                        .bold()
                        .foregroundColor(theLocal ? .primary : .secondary)
                }.foregroundColor(.secondary)
            }
        }.onReceive(Just(refresh)) {
            preferences.refresh = $0
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
        }
    }
}
