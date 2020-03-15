import AppKit

final class Article: Control {
    var favourite: Selector!
    var item: Item
    private weak var provider: Label!
    private weak var date: Label!
    private weak var title: Label!
    private weak var descr: Label!
    private weak var hearth: NSImageView!
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        let provider = Label(.key("Provider.\(item.provider)") + ":", .light(12))
        provider.setContentCompressionResistancePriority(.init(2), for: .horizontal)
        provider.maximumNumberOfLines = 1
        addSubview(provider)
        self.provider = provider
        
        let date = Label(formatter.string(from: item.date), .light(12))
        date.maximumNumberOfLines = 1
        date.lineBreakMode = .byTruncatingTail
        date.setContentCompressionResistancePriority(.init(1), for: .horizontal)
        addSubview(date)
        self.date = date
        
        let title = Label(item.title, .medium(16))
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        self.title = title
        
        let descr = Label(item.description, .regular(14))
        descr.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(descr)
        self.descr = descr
        
        let hearth = NSImageView()
        hearth.translatesAutoresizingMaskIntoConstraints = false
        hearth.imageScaling = .scaleNone
        addSubview(hearth)
        self.hearth = hearth
        
        bottomAnchor.constraint(equalTo: descr.bottomAnchor, constant: 35).isActive = true
        
        provider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        provider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        provider.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        date.topAnchor.constraint(equalTo: topAnchor).isActive = true
        date.leftAnchor.constraint(equalTo: provider.rightAnchor).isActive = true
        date.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 4).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        title.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        descr.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6).isActive = true
        descr.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descr.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        hearth.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        hearth.widthAnchor.constraint(equalToConstant: 25).isActive = true
        hearth.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        if item.status == .new {
            let new = New()
            addSubview(new)
            
            new.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            new.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            hearth.leftAnchor.constraint(equalTo: new.rightAnchor, constant: 15).isActive = true
        } else {
            hearth.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        }
        
        update()
    }
    
    override func mouseDown(with: NSEvent) {
        if !hearth.frame.contains(convert(with.locationInWindow, from: nil)) {
            hoverOn()
        }
    }
    
    override func mouseUp(with: NSEvent) {
        window!.makeFirstResponder(self)
        if hearth.frame.contains(convert(with.locationInWindow, from: nil)) {
            _ = target.perform(favourite, with: self)
        } else if bounds.contains(convert(with.locationInWindow, from: nil)) {
            _ = target.perform(click, with: self)
        } else {
            super.mouseUp(with: with)
        }
        hoverOff()
    }
    
    func update() {
        provider.textColor = item.status == .read ? .tertiaryLabelColor : .labelColor
        date.textColor = item.status == .read ? .tertiaryLabelColor : .secondaryLabelColor
        title.textColor = item.status == .read ? .tertiaryLabelColor : .headerTextColor
        descr.textColor = item.status == .read ? .tertiaryLabelColor : .secondaryLabelColor
        
        hearth.image = NSImage(named: "favourite")!.copy() as? NSImage
        hearth.image!.lockFocus()
        item.favourite ? NSColor.controlAccentColor.set() : NSColor.disabledControlTextColor.set()
        NSRect(origin: .init(), size: hearth.image!.size).fill(using: .sourceAtop)
        hearth.image!.unlockFocus()
    }
}
