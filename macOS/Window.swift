import AppKit
import Combine

final class Window: NSWindow {
    private weak var counter: Label!
    private var sub: AnyCancellable?
    
    init() {
        super.init(contentRect: .init(x: 0, y: 0, width: 1000, height: 700), styleMask: [.borderless, .miniaturizable, .resizable, .closable, .titled, .unifiedTitleAndToolbar, .fullSizeContentView], backing: .buffered, defer: false)
        minSize = .init(width: 400, height: 120)
        center()
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        toolbar = .init()
        toolbar!.showsBaselineSeparator = false
        collectionBehavior = .fullScreenNone
        isReleasedWhenClosed = false
        
        let counter = Label("", .light(12))
        counter.lineBreakMode = .byTruncatingTail
        counter.maximumNumberOfLines = 1
        counter.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        counter.textColor = .secondaryLabelColor
        contentView!.addSubview(counter)
        
        let scroll = Scroll()
        contentView!.addSubview(scroll)
        
        counter.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 75).isActive = true
        counter.centerYAnchor.constraint(equalTo: contentView!.topAnchor, constant: 19).isActive = true
        
        scroll.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 38).isActive = true
        scroll.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 1).isActive = true
        scroll.widthAnchor.constraint(equalToConstant: 250).isActive = true
        scroll.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -1).isActive = true
        scroll.width.constraint(equalToConstant: 250).isActive = true
        scroll.bottom.constraint(greaterThanOrEqualTo: scroll.bottomAnchor).isActive = true
        
        let formatter = NumberFormatter()
        sub = news.sink {
            scroll.views.forEach { $0.removeFromSuperview() }
            counter.stringValue = formatter.string(from: .init(value: $0.count))! + .key("Counter")
            guard !$0.isEmpty else { return }
            var top = scroll.top
            $0.map(Article.init(_:)).forEach {
                $0.target = self
                $0.click = #selector(self.click(_:))
                (top == scroll.top ? [$0] : [Separator(), $0]).forEach {
                    scroll.add($0)
                    $0.topAnchor.constraint(equalTo: top, constant: 20).isActive = true
                    $0.leftAnchor.constraint(equalTo: scroll.left, constant: 20).isActive = true
                    $0.rightAnchor.constraint(equalTo: scroll.right, constant: -20).isActive = true
                    top = $0.bottomAnchor
                }
            }
            scroll.bottom.constraint(greaterThanOrEqualTo: top, constant: 15).isActive = true
        }
    }
    
    override func close() {
        NSApp.terminate(nil)
    }
    
    @objc private func click(_ article: Article) {
        article.item.status = .read
        news.balam.update(article.item)
        article.update()
        NSWorkspace.shared.open(article.item.link)
    }
}
