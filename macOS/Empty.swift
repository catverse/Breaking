import AppKit

final class Empty: NSView {
    required init?(coder: NSCoder) { nil }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        
        var top = topAnchor
        [CGFloat(0.8), 0.6, 0.3, 0.7, 0.5, 0.4].forEach {
            let bar = NSView()
            bar.translatesAutoresizingMaskIntoConstraints = false
            bar.wantsLayer = true
            bar.layer!.backgroundColor = NSColor.tertiaryLabelColor.cgColor
            bar.layer!.cornerRadius = 6
            addSubview(bar)
            
            bar.topAnchor.constraint(equalTo: top, constant: 15).isActive = true
            bar.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
            bar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: $0, constant: -20).isActive = true
            bar.heightAnchor.constraint(equalToConstant: 12).isActive = true
            top = bar.bottomAnchor
        }
        bottomAnchor.constraint(equalTo: top, constant: 15).isActive = true
    }
}
