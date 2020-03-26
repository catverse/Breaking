import AppKit

final class Settings: NSWindow {
    init() {
        super.init(contentRect: .init(x: 0, y: 0, width: 300, height: 400), styleMask: [.borderless, .closable, .titled, .unifiedTitleAndToolbar, .fullSizeContentView], backing: .buffered, defer: false)
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
        filter.action = #selector(filter(_:))
        contentView!.addSubview(filter)
        
        switch news.preferences.filter {
        case .unread: filter.selectItem(at: 1)
        case .favourites: filter.selectItem(at: 2)
        default: filter.selectItem(at: 0)
        }
        
        let filterSeparator = Separator()
        contentView!.addSubview(filterSeparator)
        
        let downloadTitle = Label(.key("Settings.reload"), .light(14))
        downloadTitle.textColor = .secondaryLabelColor
        contentView!.addSubview(downloadTitle)
        
        let download = NSPopUpButton(frame: .zero)
        download.translatesAutoresizingMaskIntoConstraints = false
        download.addItems(withTitles: [.key("Reload.5"), .key("Reload.15"), .key("Reload.30"), .key("Reload.60")])
        download.target = self
        download.action = #selector(download(_:))
        contentView!.addSubview(download)
        
        switch news.preferences.refresh {
        case 15: download.selectItem(at: 1)
        case 30: download.selectItem(at: 2)
        case 60: download.selectItem(at: 3)
        default: download.selectItem(at: 0)
        }
        
        let downloadSeparator = Separator()
        contentView!.addSubview(downloadSeparator)
        
        let hideTitle = Label(.key("Settings.hide"), .light(14))
        hideTitle.textColor = .secondaryLabelColor
        contentView!.addSubview(hideTitle)
        
        let hide = NSPopUpButton(frame: .zero)
        hide.translatesAutoresizingMaskIntoConstraints = false
        hide.addItems(withTitles: [.key("Hide.7"), .key("Hide.30"), .key("Hide.365")])
        hide.target = self
        hide.action = #selector(hide(_:))
        contentView!.addSubview(hide)
        
        switch news.preferences.hide {
        case 30: hide.selectItem(at: 1)
        case 365: hide.selectItem(at: 2)
        default: hide.selectItem(at: 0)
        }
        
        let hideSeparator = Separator()
        contentView!.addSubview(hideSeparator)
        
        let providerTitle = Label(.key("Settings.providers"), .light(14))
        providerTitle.textColor = .secondaryLabelColor
        contentView!.addSubview(providerTitle)
        
        let guardian = NSButton(checkboxWithTitle: .key("Provider.guardian"), target: self, action: #selector(guardian(_:)))
        guardian.translatesAutoresizingMaskIntoConstraints = false
        guardian.state = news.preferences.providers.contains(.guardian) ? .on : .off
        contentView!.addSubview(guardian)
        
        let spiegel = NSButton(checkboxWithTitle: .key("Provider.spiegel"), target: self, action: #selector(spiegel(_:)))
        spiegel.translatesAutoresizingMaskIntoConstraints = false
        spiegel.state = news.preferences.providers.contains(.spiegel) ? .on : .off
        contentView!.addSubview(spiegel)
        
        let theLocal = NSButton(checkboxWithTitle: .key("Provider.theLocal"), target: self, action: #selector(theLocal(_:)))
        theLocal.translatesAutoresizingMaskIntoConstraints = false
        theLocal.state = news.preferences.providers.contains(.theLocal) ? .on : .off
        contentView!.addSubview(theLocal)
        
        title.centerYAnchor.constraint(equalTo: contentView!.topAnchor, constant: 19).isActive = true
        title.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor).isActive = true
        
        filterTitle.rightAnchor.constraint(equalTo: filter.leftAnchor, constant: -10).isActive = true
        filterTitle.centerYAnchor.constraint(equalTo: filter.centerYAnchor).isActive = true
        
        filter.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 60).isActive = true
        filter.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 160).isActive = true
        
        filterSeparator.topAnchor.constraint(equalTo: filter.bottomAnchor, constant: 15).isActive = true
        filterSeparator.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 40).isActive = true
        filterSeparator.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -40).isActive = true
        
        downloadTitle.rightAnchor.constraint(equalTo: download.leftAnchor, constant: -10).isActive = true
        downloadTitle.centerYAnchor.constraint(equalTo: download.centerYAnchor).isActive = true
        
        download.topAnchor.constraint(equalTo: filterSeparator.bottomAnchor, constant: 15).isActive = true
        download.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 160).isActive = true
        
        downloadSeparator.topAnchor.constraint(equalTo: download.bottomAnchor, constant: 15).isActive = true
        downloadSeparator.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 40).isActive = true
        downloadSeparator.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -40).isActive = true
        
        hideTitle.rightAnchor.constraint(equalTo: hide.leftAnchor, constant: -10).isActive = true
        hideTitle.centerYAnchor.constraint(equalTo: hide.centerYAnchor).isActive = true
        
        hide.topAnchor.constraint(equalTo: downloadSeparator.bottomAnchor, constant: 15).isActive = true
        hide.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 160).isActive = true
        
        hideSeparator.topAnchor.constraint(equalTo: hide.bottomAnchor, constant: 15).isActive = true
        hideSeparator.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 40).isActive = true
        hideSeparator.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -40).isActive = true
        
        providerTitle.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor).isActive = true
        providerTitle.topAnchor.constraint(equalTo: hideSeparator.bottomAnchor, constant: 20).isActive = true
        
        guardian.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 100).isActive = true
        guardian.topAnchor.constraint(equalTo: providerTitle.bottomAnchor, constant: 20).isActive = true
        
        spiegel.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 100).isActive = true
        spiegel.topAnchor.constraint(equalTo: guardian.bottomAnchor, constant: 20).isActive = true
        
        theLocal.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 100).isActive = true
        theLocal.topAnchor.constraint(equalTo: spiegel.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc private func filter(_ button: NSPopUpButton) {
        switch button.indexOfSelectedItem {
        case 1: news.preferences.filter = .unread
        case 2: news.preferences.filter = .favourites
        default: news.preferences.filter = .all
        }
        news.save()
        news.reload()
    }
    
    @objc private func download(_ button: NSPopUpButton) {
        switch button.indexOfSelectedItem {
        case 1: news.preferences.refresh = 15
        case 2: news.preferences.refresh = 30
        case 3: news.preferences.refresh = 60
        default: news.preferences.refresh = 5
        }
        news.save()
    }
    
    @objc private func hide(_ button: NSPopUpButton) {
        switch button.indexOfSelectedItem {
        case 1: news.preferences.hide = 30
        case 2: news.preferences.hide = 365
        default: news.preferences.hide = 7
        }
        news.save()
        news.reload()
    }
    
    @objc private func guardian(_ button: NSButton) {
        news.preferences.providers.removeAll { $0 == .guardian }
        if button.state == .on {
            news.preferences.providers.append(.guardian)
        }
        news.save()
        news.reload()
    }
    
    @objc private func spiegel(_ button: NSButton) {
        news.preferences.providers.removeAll { $0 == .spiegel }
        if button.state == .on {
            news.preferences.providers.append(.spiegel)
        }
        news.save()
        news.reload()
    }
    
    @objc private func theLocal(_ button: NSButton) {
        news.preferences.providers.removeAll { $0 == .theLocal }
        if button.state == .on {
            news.preferences.providers.append(.theLocal)
        }
        news.save()
        news.reload()
    }
}
