import AppKit
import Combine

final class Window: NSWindow {
    let news = News()
    private weak var counter: Label!
    private var sub: AnyCancellable?
    
    init() {
        super.init(contentRect: .init(x: 0, y: 0, width: 600, height: 800), styleMask: [.borderless, .miniaturizable, .resizable, .closable, .titled, .unifiedTitleAndToolbar, .fullSizeContentView], backing: .buffered, defer: false)
        minSize = .init(width: 200, height: 120)
        center()
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        toolbar = .init()
        toolbar!.showsBaselineSeparator = false
        collectionBehavior = .fullScreenNone
        isReleasedWhenClosed = false
        
        let formatter = NumberFormatter()
        
        let blur = NSVisualEffectView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        contentView!.addSubview(blur)
        
        let counter = Label("", .medium(12))
        counter.lineBreakMode = .byTruncatingTail
        counter.maximumNumberOfLines = 1
        counter.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        counter.textColor = .tertiaryLabelColor
        contentView!.addSubview(counter)
        
        let scroll = Scroll()
        contentView!.addSubview(scroll)
        
        blur.topAnchor.constraint(equalTo: contentView!.topAnchor).isActive = true
        blur.leftAnchor.constraint(equalTo: contentView!.leftAnchor).isActive = true
        blur.rightAnchor.constraint(equalTo: contentView!.rightAnchor).isActive = true
        blur.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        counter.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -30).isActive = true
        counter.centerYAnchor.constraint(equalTo: blur.centerYAnchor).isActive = true
        
        scroll.topAnchor.constraint(equalTo: blur.bottomAnchor, constant: 1).isActive = true
        scroll.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 1).isActive = true
        scroll.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -1).isActive = true
        scroll.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -1).isActive = true
        scroll.right.constraint(equalTo: scroll.rightAnchor).isActive = true
        scroll.bottom.constraint(greaterThanOrEqualTo: scroll.bottomAnchor).isActive = true
        
        sub = news.$items.receive(on: DispatchQueue.main).sink {
            scroll.views.forEach { $0.removeFromSuperview() }
            counter.stringValue = formatter.string(from: .init(value: $0.count))! + .key("Counter")
            guard !$0.isEmpty else { return }
            var top = scroll.top
            $0.sorted { $0.date > $1.date }.map(Article.init(_:)).forEach {
                $0.target = self
                $0.click = #selector(self.click(_:))
                $0.hearth = #selector(self.hearth(_:))
                (top == scroll.top ? [$0] : [Separator(), $0]).forEach {
                    scroll.add($0)
                    $0.topAnchor.constraint(equalTo: top, constant: 15).isActive = true
                    $0.leftAnchor.constraint(equalTo: scroll.left, constant: 30).isActive = true
                    $0.rightAnchor.constraint(equalTo: scroll.right, constant: -30).isActive = true
                    top = $0.bottomAnchor
                }
            }
            scroll.bottom.constraint(greaterThanOrEqualTo: top, constant: 15).isActive = true
        }
    }
    
    override func close() {
        NSApp.terminate(nil)
    }
    
    @objc private func hearth(_ article: Article) {
        article.toggleFavourite()
        news.favourite(article.item, favourite: article._favourite)
    }
    
    @objc private func click(_ article: Article) {
        news.read(article.item)
        NSWorkspace.shared.open(article.item.link)
    }
}
