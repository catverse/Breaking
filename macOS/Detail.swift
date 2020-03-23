import AppKit

final class Detail: NSView {
    private let item: Item
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let title = Label(item.title, .medium(16))
        title.textColor = .headerColor
        addSubview(title)
        
        title.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
