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
        
        let title = Label(.key("Settings.title"), .medium(12))
        contentView!.addSubview(title)
        
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
        
        let downloadTitle = Label(.key("Settings.reload"), .light(14))
        downloadTitle.textColor = .secondaryLabelColor
        contentView!.addSubview(downloadTitle)
        
        let download = NSPopUpButton(frame: .zero)
        download.translatesAutoresizingMaskIntoConstraints = false
        download.addItems(withTitles: [.key("Reload.5"), .key("Reload.15"), .key("Reload.30"), .key("Reload.60")])
        download.target = self
        download.action = #selector(self.download(_:))
        contentView!.addSubview(download)
        
        switch news.preferences.refresh {
        case 15: download.selectItem(at: 1)
        case 30: download.selectItem(at: 2)
        case 60: download.selectItem(at: 3)
        default: download.selectItem(at: 0)
        }
        
        title.centerYAnchor.constraint(equalTo: contentView!.topAnchor, constant: 19).isActive = true
        title.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor).isActive = true
        
        filterTitle.rightAnchor.constraint(equalTo: filter.leftAnchor, constant: -10).isActive = true
        filterTitle.centerYAnchor.constraint(equalTo: filter.centerYAnchor).isActive = true
        
        filter.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 60).isActive = true
        filter.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 160).isActive = true
        
        downloadTitle.rightAnchor.constraint(equalTo: download.leftAnchor, constant: -10).isActive = true
        downloadTitle.centerYAnchor.constraint(equalTo: download.centerYAnchor).isActive = true
        
        download.topAnchor.constraint(equalTo: filter.bottomAnchor, constant: 30).isActive = true
        download.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 160).isActive = true
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
    
    @objc private func download(_ button: NSPopUpButton) {
        switch button.indexOfSelectedItem {
        case 1: news.preferences.refresh = 15
        case 2: news.preferences.refresh = 30
        case 3: news.preferences.refresh = 60
        default: news.preferences.refresh = 5
        }
        news.balam.update(news.preferences)
    }
}
