import AppKit

final class Article: Control {
    var item: Item
    var selected = false {
        didSet {
            NSAnimationContext.runAnimationGroup {
                $0.duration = 0.5
                $0.allowsImplicitAnimation = true
                layer!.backgroundColor =  selected ? NSColor(named: "lightning")!.cgColor : .clear
                appearance = selected ? NSAppearance(named: .aqua) : nil
            }
        }
    }
    
    private weak var provider: Label!
    private weak var date: Label!
    private weak var title: Label!
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init()
        wantsLayer = true
        layer!.backgroundColor = .clear
        
        let provider = Label(.key("Provider.\(item.provider)"), .light(10))
        provider.setContentCompressionResistancePriority(.init(2), for: .horizontal)
        provider.maximumNumberOfLines = 1
        addSubview(provider)
        self.provider = provider
        
        let date = Label(item.date > Calendar.current.date(byAdding: .hour, value: -23, to: .init())!
            ? RelativeDateTimeFormatter().localizedString(for: item.date, relativeTo: .init())
            : {
                $0.dateStyle = .medium
                $0.timeStyle = .none
                return $0.string(from: item.date)
            } (DateFormatter()), .light(10))
        date.maximumNumberOfLines = 1
        date.lineBreakMode = .byTruncatingTail
        date.setContentCompressionResistancePriority(.init(1), for: .horizontal)
        date.textColor = .secondaryLabelColor
        addSubview(date)
        self.date = date
        
        let title = Label(item.title, .regular(12))
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        title.textColor = .headerTextColor
        addSubview(title)
        self.title = title
        
        bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        
        provider.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        provider.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        
        date.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        date.leftAnchor.constraint(greaterThanOrEqualTo: provider.rightAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 15).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        title.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -10).isActive = true
        
        update()
    }
    
    func update() {
        provider.alphaValue = item.status == .read ? 0.4 : 1
        date.alphaValue = item.status == .read ? 0.6 : 1
        title.alphaValue = item.status == .read ? 0.4 : 1
        
//        provider.textColor = item.status == .read ? .tertiaryLabelColor : .labelColor
//        date.textColor = item.status == .read ? .tertiaryLabelColor : .secondaryLabelColor
//        title.textColor = item.status == .read ? .tertiaryLabelColor : .headerTextColor
        
//        hearth.image = NSImage(named: "favourite")!.copy() as? NSImage
//        hearth.image!.lockFocus()
//        item.favourite ? NSColor.controlAccentColor.set() : NSColor.tertiaryLabelColor.set()
//        NSRect(origin: .init(), size: hearth.image!.size).fill(using: .sourceIn)
//        hearth.image!.unlockFocus()
    }
}
