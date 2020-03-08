import AppKit

final class New: NSView {
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        layer!.cornerRadius = 4
        
        let label = Label(.key("Badge.New"), .medium(12))
        label.textColor = .selectedControlTextColor
        addSubview(label)
        
        heightAnchor.constraint(equalToConstant: 25).isActive = true
        leftAnchor.constraint(equalTo: label.leftAnchor, constant: -6).isActive = true
        rightAnchor.constraint(equalTo: label.rightAnchor, constant: 6).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override func updateLayer() {
        layer!.backgroundColor = NSColor.controlAccentColor.cgColor
    }
}
