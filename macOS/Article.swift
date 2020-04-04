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
    private weak var title: Label!
    private weak var new: Label!
    private weak var favourite: NSImageView!
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init()
        wantsLayer = true
        layer!.backgroundColor = .clear
        
        let provider = Label(.key("Provider.\(item.provider)") + ": " + (item.date > Calendar.current.date(byAdding: .hour, value: -23, to: .init())!
        ? RelativeDateTimeFormatter().localizedString(for: item.date, relativeTo: .init())
        : {
            $0.dateStyle = .medium
            $0.timeStyle = .none
            return $0.string(from: item.date)
        } (DateFormatter())), .regular(11))
        provider.setContentCompressionResistancePriority(.init(2), for: .horizontal)
        provider.textColor = .secondaryLabelColor
        provider.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(provider)
        self.provider = provider
        
        let title = Label(item.title, .regular(14))
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        self.title = title
        
        let favourite = NSImageView()
        favourite.translatesAutoresizingMaskIntoConstraints = false
        favourite.imageScaling = .scaleProportionallyDown
        addSubview(favourite)
        self.favourite = favourite
        
        let new = Label("+", .light(25))
        addSubview(new)
        self.new = new
        
        bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        
        provider.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        provider.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        provider.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -18).isActive = true
        
        title.topAnchor.constraint(equalTo: provider.bottomAnchor, constant: 8).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        title.rightAnchor.constraint(lessThanOrEqualTo: new.leftAnchor, constant: -5).isActive = true
        
        favourite.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        favourite.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: -3).isActive = true
        favourite.heightAnchor.constraint(equalToConstant: 14).isActive = true
        favourite.widthAnchor.constraint(equalToConstant: 14).isActive = true
        
        new.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        new.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        update()
    }
    
    func update() {
        provider.alphaValue = item.status == .read ? 0.4 : 1
        title.alphaValue = item.status == .read ? 0.4 : 1
        new.isHidden = item.status != .new
        
        if item.favourite {
            favourite.image = NSImage(named: "favourite")!.copy() as? NSImage
            favourite.image!.lockFocus()
            NSColor.tertiaryLabelColor.set()
            NSRect(origin: .init(), size: favourite.image!.size).fill(using: .sourceIn)
            favourite.image!.unlockFocus()
        } else {
            favourite.image = nil
        }
    }
}
