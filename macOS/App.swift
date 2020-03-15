import AppKit

@NSApplicationMain final class App: NSApplication, NSApplicationDelegate {
    private weak var window: Window!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        delegate = self
    }
    
    func applicationDidBecomeActive(_: Notification) {
        window.news.refresh()
    }
    
    func applicationWillFinishLaunching(_: Notification) {
        mainMenu = Menu()
        let window = Window()
        self.window = window
        window.makeKeyAndOrderFront(nil)
    }
}
