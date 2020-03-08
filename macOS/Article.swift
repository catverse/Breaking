import AppKit

final class Article: NSView {
    private let item: Item
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        let date = Label(formatter.string(from: item.date), .light(12))
        date.textColor = .tertiaryLabelColor
        date.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(date)
        
        let title = Label(item.title, .medium(16))
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        
        let description = Label(item.description, .regular(14))
        description.textColor = .secondaryLabelColor
        description.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(description)
        
        bottomAnchor.constraint(equalTo: description.bottomAnchor).isActive = true
        
        date.topAnchor.constraint(equalTo: topAnchor).isActive = true
        date.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        date.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 4).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        title.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
        
        description.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6).isActive = true
        description.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        description.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
    }
}
