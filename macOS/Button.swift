import AppKit

final class Button: Control {
    required init?(coder: NSCoder) { nil }
    init(_ title: String) {
        super.init()
        wantsLayer = true
        layer!.cornerRadius = 6
        layer!.backgroundColor = NSColor(named: "lightning")!.cgColor
        
        let label = Label(title, .medium(13))
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        addSubview(label)
        
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        rightAnchor.constraint(equalTo: label.rightAnchor, constant: 16).isActive = true
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    }
}
