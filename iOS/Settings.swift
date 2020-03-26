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
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Settings.reload")) {
                Picker(selection: $refresh, label: Text("Settings.reload")) {
                    Text("Reload.5").tag(5)
                    Text("Reload.15").tag(15)
                    Text("Reload.30").tag(30)
                    Text("Reload.60").tag(60)
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Settings.hide")) {
                Picker(selection: $hide, label: Text("Settings.hide")) {
                    Text("Hide.7").tag(7)
                    Text("Hide.30").tag(30)
                    Text("Hide.365").tag(365)
                }.pickerStyle(SegmentedPickerStyle())
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
        }.listStyle(GroupedListStyle())
            .navigationBarTitle(.init("Settings.title"), displayMode: .inline)
        .onDisappear {
            news.preferences.filter = self.filter
            news.preferences.refresh = self.refresh
            news.preferences.hide = self.hide
            news.preferences.providers =
                (self.guardian ? [.guardian] : []) +
                (self.spiegel ? [.spiegel] : []) +
                (self.theLocal ? [.theLocal] : [])
            news.savePreferences()
        }
    }
}
