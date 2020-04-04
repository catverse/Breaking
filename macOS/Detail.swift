import AppKit

final class Detail: NSView {
    private weak var article: Article!
    
    required init?(coder: NSCoder) { nil }
    init(_ article: Article) {
        self.article = article
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        alphaValue = 0
        
        let provider = Label(.key("Provider.\(article.item.provider)"), .light(14))
        provider.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        provider.maximumNumberOfLines = 1
        addSubview(provider)
        
        let date = Label(article.item.date > Calendar.current.date(byAdding: .hour, value: -23, to: .init())!
            ? RelativeDateTimeFormatter().localizedString(for: article.item.date, relativeTo: .init())
            : {
                $0.dateStyle = .full
                $0.timeStyle = .short
                return $0.string(from: article.item.date)
            } (DateFormatter()), .light(14))
        date.maximumNumberOfLines = 1
        date.lineBreakMode = .byTruncatingTail
        date.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        date.textColor = .secondaryLabelColor
        addSubview(date)
        
        let title = Label(article.item.title, .medium(18))
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(title)
        
        let descr = Label(article.item.description, .regular(18))
        descr.textColor = .secondaryLabelColor
        descr.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        addSubview(descr)
        
        let favourite = Favourite()
        favourite.target = self
        favourite.action = #selector(toggle(_:))
        addSubview(favourite)
        favourite.update(article.item.favourite)
        
        let read = Button(.key("More"))
        read.target = self
        read.action = #selector(open)
        addSubview(read)
        
        bottomAnchor.constraint(equalTo: read.bottomAnchor, constant: 60).isActive = true
        
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
        favourite.topAnchor.constraint(equalTo: descr.bottomAnchor, constant: 30).isActive = true
        
        read.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        read.topAnchor.constraint(equalTo: favourite.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc private func toggle(_ favourite: Favourite) {
        article.item.favourite.toggle()
        favourite.update(article.item.favourite)
        article.update()
        news.balam.update(article.item)
    }
    
    @objc private func open() {
        NSWorkspace.shared.open(article.item.link)
    }
}
