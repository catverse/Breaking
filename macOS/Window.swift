import AppKit
import Combine

final class Window: NSWindow {
    private weak var counter: Label!
    private var sub: AnyCancellable?
    
    init() {
        super.init(contentRect: .init(x: 0, y: 0, width: 400, height: 800), styleMask: [.borderless, .miniaturizable, .resizable, .closable, .titled, .unifiedTitleAndToolbar, .fullSizeContentView], backing: .buffered, defer: false)
        minSize = .init(width: 180, height: 120)
        center()
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        toolbar = .init()
        toolbar!.showsBaselineSeparator = false
        collectionBehavior = .fullScreenNone
        isReleasedWhenClosed = false
        
        let blur = NSVisualEffectView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.blendingMode = .withinWindow
        contentView!.addSubview(blur)
        
        let counter = Label("", .regular(12))
        counter.lineBreakMode = .byTruncatingTail
        counter.maximumNumberOfLines = 1
        counter.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        counter.textColor = .secondaryLabelColor
        contentView!.addSubview(counter)
        
        let scroll = Scroll()
        contentView!.addSubview(scroll)
        
        blur.topAnchor.constraint(equalTo: contentView!.topAnchor).isActive = true
        blur.leftAnchor.constraint(equalTo: contentView!.leftAnchor).isActive = true
        blur.rightAnchor.constraint(equalTo: contentView!.rightAnchor).isActive = true
        blur.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        counter.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -20).isActive = true
        counter.centerYAnchor.constraint(equalTo: blur.centerYAnchor).isActive = true
        
        scroll.topAnchor.constraint(equalTo: blur.bottomAnchor, constant: 1).isActive = true
        scroll.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 1).isActive = true
        scroll.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -1).isActive = true
        scroll.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -1).isActive = true
        scroll.right.constraint(equalTo: scroll.rightAnchor).isActive = true
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
