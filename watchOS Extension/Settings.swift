import SwiftUI
import Combine

struct Settings: View {
    @State private var filter = news.preferences.filter
    @State private var refresh = news.preferences.refresh
    @State private var hide = news.preferences.hide
    @State private var guardian = news.preferences.providers.contains(.guardian)
    @State private var spiegel = news.preferences.providers.contains(.spiegel)
    @State private var theLocal = news.preferences.providers.contains(.theLocal)
    
    var body: some View {
        List {
            Section {
                Picker(selection: $filter, label: Text("Settings.filter")) {
                    Text("Filter.all").tag(Filter.all)
                    Text("Filter.unread").tag(Filter.unread)
                    Text("Filter.favourites").tag(Filter.favourites)
                }.pickerStyle(WheelPickerStyle())
            }
            Section {
                Picker(selection: $refresh, label: Text("Settings.reload")) {
                    Text("Reload.5").tag(5)
                    Text("Reload.15").tag(15)
                    Text("Reload.30").tag(30)
                    Text("Reload.60").tag(60)
                }
            }
            Section {
                Picker(selection: $hide, label: Text("Settings.hide")) {
                    Text("Hide.7").tag(7)
                    Text("Hide.30").tag(30)
                    Text("Hide.365").tag(365)
                }
            }
            Section(header: Text("Settings.providers")) {
                Toggle(isOn: $guardian) {
                    Text("Provider.guardian")
                        .font(.footnote)
                        .foregroundColor(guardian ? .primary : .secondary)
                }
                Toggle(isOn: $spiegel) {
                    Text("Provider.spiegel")
                        .font(.footnote)
                        .foregroundColor(spiegel ? .primary : .secondary)
                }
                Toggle(isOn: $theLocal) {
                    Text("Provider.theLocal")
                        .font(.footnote)
                        .foregroundColor(theLocal ? .primary : .secondary)
                }
            }
        }.navigationBarTitle(.init("Settings.title"))
            .onAppear {
                self.filter = news.preferences.filter
                self.refresh = news.preferences.refresh
                self.hide = news.preferences.hide
                self.guardian = news.preferences.providers.contains(.guardian)
                self.spiegel = news.preferences.providers.contains(.spiegel)
                self.theLocal = news.preferences.providers.contains(.theLocal)
        }.onDisappear {
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
