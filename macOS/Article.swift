import AppKit

final class Article: Control {
    let item: Item
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
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
        
        if item.new {
            let new = New()
            addSubview(new)
            
            new.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            new.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        }
    }
}
