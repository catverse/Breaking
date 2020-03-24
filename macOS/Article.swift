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
    private weak var new: Label!
    private weak var favourite: NSImageView!
    private weak var titleRight: NSLayoutConstraint!
    
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
        
        let favourite = NSImageView()
        favourite.translatesAutoresizingMaskIntoConstraints = false
        favourite.imageScaling = .scaleProportionallyDown
        addSubview(favourite)
        self.favourite = favourite
        
        let new = Label("+", .systemFont(ofSize: 18, weight: .light))
        new.textColor = .headerColor
        addSubview(new)
        self.new = new
        
        bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        
        provider.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        provider.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        
        date.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -17).isActive = true
        date.leftAnchor.constraint(greaterThanOrEqualTo: provider.rightAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 15).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        titleRight = title.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: 0)
        titleRight.isActive = true
        
        favourite.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        favourite.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: -3).isActive = true
        favourite.heightAnchor.constraint(equalToConstant: 10).isActive = true
        favourite.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        new.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        new.topAnchor.constraint(equalTo: title.topAnchor, constant: -3).isActive = true
        
        update()
    }
    
    func update() {
        provider.alphaValue = item.status == .read ? 0.4 : 1
        date.alphaValue = item.status == .read ? 0.6 : 1
        title.alphaValue = item.status == .read ? 0.4 : 1
        new.isHidden = item.status != .new
        
        if item.favourite {
            favourite.image = NSImage(named: "favourite")!.copy() as? NSImage
            favourite.image!.lockFocus()
            NSColor.secondaryLabelColor.set()
            NSRect(origin: .init(), size: favourite.image!.size).fill(using: .sourceIn)
            favourite.image!.unlockFocus()
        } else {
            favourite.image = nil
        }
        
        if item.favourite || item.status == .new {
            titleRight.constant = -29
        } else {
            titleRight.constant = -17
        }
    }
}
