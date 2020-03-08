import AppKit

final class Article: NSView {
    private let item: Item
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let title = Label(item.title, .medium(16))
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        
        bottomAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        title.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
    }
}
