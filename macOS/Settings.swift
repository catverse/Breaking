import AppKit

final class Settings: NSWindow {
    init() {
        super.init(contentRect: .init(x: 0, y: 0, width: 300, height: 300), styleMask: [.borderless, .closable, .titled, .unifiedTitleAndToolbar, .fullSizeContentView], backing: .buffered, defer: false)
        center()
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        toolbar = .init()
        toolbar!.showsBaselineSeparator = false
        collectionBehavior = .fullScreenNone
        isReleasedWhenClosed = false
        
        let filterTitle = Label(.key("Settings.filter"), .light(14))
        filterTitle.textColor = .secondaryLabelColor
        contentView!.addSubview(filterTitle)
        
        let filter = NSPopUpButton(frame: .zero)
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.addItems(withTitles: [.key("Filter.all"), .key("Filter.unread"), .key("Filter.favourites")])
        filter.target = self
        filter.action = #selector(self.filter(_:))
        contentView!.addSubview(filter)
        
        switch news.preferences.filter {
        case .unread: filter.selectItem(at: 1)
        case .favourites: filter.selectItem(at: 2)
        default: filter.selectItem(at: 0)
        }
        
        filterTitle.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 60).isActive = true
        filterTitle.centerYAnchor.constraint(equalTo: filter.centerYAnchor).isActive = true
        
        filter.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 60).isActive = true
        filter.leftAnchor.constraint(equalTo: filterTitle.rightAnchor, constant: 20).isActive = true
    }
    
    @objc private func filter(_ button: NSPopUpButton) {
        switch button.indexOfSelectedItem {
        case 1: news.preferences.filter = .unread
        case 2: news.preferences.filter = .favourites
        default: news.preferences.filter = .all
        }
        news.balam.update(news.preferences)
        news.reload()
    }
}
