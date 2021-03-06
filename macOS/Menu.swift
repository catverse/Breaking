import AppKit

final class Menu: NSMenu {
    required init(coder: NSCoder) { fatalError() }
    init() {
        super.init(title: "")
        items = [breaking, articles, window, help]
    }

    private var breaking: NSMenuItem {
        menu(.key("Menu.breaking"), items: [
            .init(title: .key("Menu.about"), action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""),
        .separator(),
        .init(title: .key("Menu.preferences"), action: #selector(App.preferences), keyEquivalent: ","),
        .separator(),
        .init(title: .key("Menu.hide"), action: #selector(NSApplication.hide), keyEquivalent: "h"),
        {
            $0.keyEquivalentModifierMask = [.option, .command]
            return $0
        } (NSMenuItem(title: .key("Menu.hideOthers"), action: #selector(NSApplication.hideOtherApplications), keyEquivalent: "h")),
        .init(title: .key("Menu.showAll"), action: #selector(NSApplication.unhideAllApplications), keyEquivalent: ""),
        .separator(),
        .init(title: .key("Menu.quit"), action: #selector(NSApplication.terminate), keyEquivalent: "q")])
    }
    
    private var articles: NSMenuItem {
        menu(.key("Menu.articles"), items: [
            {
                $0.keyEquivalentModifierMask = []
                return $0
            } (NSMenuItem(title: .key("Menu.previous"), action: #selector(Window.prev), keyEquivalent: .init(Character(UnicodeScalar(NSUpArrowFunctionKey)!)))),
            {
                $0.keyEquivalentModifierMask = []
                return $0
            } (NSMenuItem(title: .key("Menu.next"), action: #selector(Window.next), keyEquivalent: .init(Character(UnicodeScalar(NSDownArrowFunctionKey)!)))),
            .separator(),
            {
                $0.keyEquivalentModifierMask = []
                return $0
            } (NSMenuItem(title: .key("Menu.first"), action: #selector(Window.first), keyEquivalent: .init(Character(UnicodeScalar(NSLeftArrowFunctionKey)!)))),
            {
                $0.keyEquivalentModifierMask = []
                return $0
            } (NSMenuItem(title: .key("Menu.last"), action: #selector(Window.last), keyEquivalent: .init(Character(UnicodeScalar(NSRightArrowFunctionKey)!))))])
    }
    
    private var window: NSMenuItem {
        menu(.key("Menu.window"), items: [
            .init(title: .key("Menu.minimize"), action: #selector(Window.miniaturize), keyEquivalent: "m"),
            .init(title: .key("Menu.zoom"), action: #selector(Window.zoom), keyEquivalent: "p"),
            .separator(),
            .init(title: .key("Menu.bringAll"), action: #selector(NSApplication.arrangeInFront), keyEquivalent: ""),
            .separator(),
            .init(title: .key("Menu.close"), action: #selector(NSWindow.close), keyEquivalent: "w")])
    }
    
    private var help: NSMenuItem {
        menu(.key("Menu.help"), items: [])
    }
    
    private func menu(_ name: String, items: [NSMenuItem]) -> NSMenuItem {
        let menu = NSMenuItem(title: "", action: nil, keyEquivalent: "")
        menu.submenu = .init(title: name)
        menu.submenu?.items = items
        return menu
    }
}
