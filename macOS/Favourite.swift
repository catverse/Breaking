import AppKit

final class Favourite: Control {
    private weak var image: NSImageView!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        let image = NSImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.imageScaling = .scaleNone
        addSubview(image)
        self.image = image
        
        widthAnchor.constraint(equalToConstant: 50).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func update(_ active: Bool) {
        image.image = NSImage(named: "favourite")!.copy() as? NSImage
        image.image!.lockFocus()
        active ? NSColor(named: "lightning")!.set() : NSColor.tertiaryLabelColor.set()
        NSRect(origin: .init(), size: image.image!.size).fill(using: .sourceIn)
        image.image!.unlockFocus()
    }
}
