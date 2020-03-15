import AppKit

final class Article: Control {
    var favourite: Selector!
    var item: Item
    private weak var hearth: NSImageView!
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        let provider = Label(.key("Provider.\(item.provider)") + ":", .light(12))
        provider.textColor = item.status == .read ? .tertiaryLabelColor : .labelColor
        provider.setContentCompressionResistancePriority(.init(2), for: .horizontal)
        provider.maximumNumberOfLines = 1
        addSubview(provider)
        
        let date = Label(formatter.string(from: item.date), .light(12))
        date.maximumNumberOfLines = 1
        date.lineBreakMode = .byTruncatingTail
        date.textColor = item.status == .read ? .tertiaryLabelColor : .secondaryLabelColor
        date.setContentCompressionResistancePriority(.init(1), for: .horizontal)
        addSubview(date)
        
        let title = Label(item.title, .medium(16))
        title.textColor = item.status == .read ? .tertiaryLabelColor : .headerTextColor
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        
        let description = Label(item.description, .regular(14))
        description.textColor = item.status == .read ? .tertiaryLabelColor : .secondaryLabelColor
        description.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(description)
        
        let hearth = NSImageView()
        hearth.translatesAutoresizingMaskIntoConstraints = false
        hearth.imageScaling = .scaleNone
        addSubview(hearth)
        self.hearth = hearth
        
        bottomAnchor.constraint(equalTo: description.bottomAnchor, constant: 35).isActive = true
        
        provider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        provider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        provider.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        date.topAnchor.constraint(equalTo: topAnchor).isActive = true
        date.leftAnchor.constraint(equalTo: provider.rightAnchor).isActive = true
        date.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 4).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        title.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        description.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6).isActive = true
        description.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        description.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
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
        
        updateFavourite()
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
    
    func updateFavourite() {
        hearth.image = NSImage(named: "favourite")!.copy() as? NSImage
        hearth.image!.lockFocus()
        item.favourite ? NSColor.controlAccentColor.set() : NSColor.disabledControlTextColor.set()
        NSRect(origin: .init(), size: hearth.image!.size).fill(using: .sourceAtop)
        hearth.image!.unlockFocus()
    }
}
