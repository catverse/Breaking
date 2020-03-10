import AppKit

final class Article: Control {
    var hearth: Selector!
    let item: Item
    private(set) var _favourite: Bool
    private weak var favourite: NSImageView!
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        _favourite = item.favourite
        super.init()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        let provider = Label(.key("Provider.\(item.provider)") + ":", .light(12))
        provider.textColor = item.new ? .labelColor : .tertiaryLabelColor
        provider.setContentCompressionResistancePriority(.init(2), for: .horizontal)
        provider.maximumNumberOfLines = 1
        addSubview(provider)
        
        let date = Label(formatter.string(from: item.date), .light(12))
        date.maximumNumberOfLines = 1
        date.lineBreakMode = .byTruncatingTail
        date.textColor = item.new ? .secondaryLabelColor : .tertiaryLabelColor
        date.setContentCompressionResistancePriority(.init(1), for: .horizontal)
        addSubview(date)
        
        let title = Label(item.title, .medium(16))
        title.textColor = item.new ? .headerTextColor : .tertiaryLabelColor
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        
        let description = Label(item.description, .regular(14))
        description.textColor = item.new ? .secondaryLabelColor : .tertiaryLabelColor
        description.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(description)
        
        let favourite = NSImageView()
        favourite.translatesAutoresizingMaskIntoConstraints = false
        favourite.imageScaling = .scaleNone
        addSubview(favourite)
        self.favourite = favourite
        
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
        
        favourite.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        favourite.widthAnchor.constraint(equalToConstant: 25).isActive = true
        favourite.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        if item.new {
            let new = New()
            addSubview(new)
            
            new.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            new.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            favourite.leftAnchor.constraint(equalTo: new.rightAnchor, constant: 15).isActive = true
        } else {
            favourite.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        }
        
        update()
    }
    
    override func mouseDown(with: NSEvent) {
        if !favourite.frame.contains(convert(with.locationInWindow, from: nil)) {
            hoverOn()
        }
    }
    
    override func mouseUp(with: NSEvent) {
        window!.makeFirstResponder(self)
        if favourite.frame.contains(convert(with.locationInWindow, from: nil)) {
            _ = target.perform(hearth, with: self)
        } else if bounds.contains(convert(with.locationInWindow, from: nil)) {
            _ = target.perform(click, with: self)
        } else {
            super.mouseUp(with: with)
        }
        hoverOff()
    }
    
    func toggleFavourite() {
        _favourite.toggle()
        update()
    }
    
    private func update() {
        favourite.image = NSImage(named: "favourite")!.copy() as? NSImage
        favourite.image!.lockFocus()
        _favourite ? NSColor.controlAccentColor.set() : NSColor.disabledControlTextColor.set()
        NSRect(origin: .init(), size: favourite.image!.size).fill(using: .sourceAtop)
        favourite.image!.unlockFocus()
    }
}
