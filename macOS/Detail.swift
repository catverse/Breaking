import AppKit

final class Detail: NSView {
    private weak var favourite: Favourite!
    private var item: Item
    
    required init?(coder: NSCoder) { nil }
    init(_ item: Item) {
        self.item = item
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        alphaValue = 0
        
        let provider = Label(.key("Provider.\(item.provider)"), .light(13))
        provider.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        provider.maximumNumberOfLines = 1
        addSubview(provider)
        
        let date = Label(item.date > Calendar.current.date(byAdding: .hour, value: -23, to: .init())!
            ? RelativeDateTimeFormatter().localizedString(for: item.date, relativeTo: .init())
            : {
                $0.dateStyle = .full
                $0.timeStyle = .short
                return $0.string(from: item.date)
            } (DateFormatter()), .light(13))
        date.maximumNumberOfLines = 1
        date.lineBreakMode = .byTruncatingTail
        date.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        date.textColor = .secondaryLabelColor
        addSubview(date)
        
        let title = Label(item.title, .regular(16))
        title.textColor = .headerColor
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        
        let descr = Label(item.description, .regular(16))
        descr.textColor = .secondaryLabelColor
        descr.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(descr)
        
        let favourite = Favourite()
        addSubview(favourite)
        favourite.update(item.favourite)
        self.favourite = favourite
        
        bottomAnchor.constraint(equalTo: favourite.bottomAnchor).isActive = true
        
        provider.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        provider.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        
        date.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        date.leftAnchor.constraint(greaterThanOrEqualTo: provider.rightAnchor, constant: 5).isActive = true
        
        title.topAnchor.constraint(equalTo: provider.bottomAnchor, constant: 20).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        title.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -50).isActive = true
        title.widthAnchor.constraint(lessThanOrEqualToConstant: 800).isActive = true
        
        descr.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        descr.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        descr.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -50).isActive = true
        descr.widthAnchor.constraint(lessThanOrEqualToConstant: 800).isActive = true
        
        favourite.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        favourite.topAnchor.constraint(equalTo: descr.bottomAnchor, constant: 40).isActive = true
    }
}
