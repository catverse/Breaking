import AppKit
import Combine

final class Window: NSWindow {
    private weak var counter: Label!
    private weak var list: Scroll!
    private weak var content: Scroll!
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
        
        let list = Scroll()
        contentView!.addSubview(list)
        self.list = list
        
        let content = Scroll()
        contentView!.addSubview(content)
        self.content = content
        
        counter.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 75).isActive = true
        counter.centerYAnchor.constraint(equalTo: contentView!.topAnchor, constant: 19).isActive = true
        
        list.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 38).isActive = true
        list.leftAnchor.constraint(equalTo: contentView!.leftAnchor, constant: 1).isActive = true
        list.widthAnchor.constraint(equalToConstant: 250).isActive = true
        list.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -1).isActive = true
        list.width.constraint(equalToConstant: 250).isActive = true
        list.bottom.constraint(greaterThanOrEqualTo: list.bottomAnchor).isActive = true
        
        content.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 38).isActive = true
        content.leftAnchor.constraint(equalTo: list.rightAnchor, constant: 1).isActive = true
        content.rightAnchor.constraint(equalTo: contentView!.rightAnchor, constant: -1).isActive = true
        content.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -1).isActive = true
        content.right.constraint(equalTo: contentView!.rightAnchor).isActive = true
        content.bottom.constraint(greaterThanOrEqualTo: content.bottomAnchor).isActive = true
        
        let formatter = NumberFormatter()
        sub = news.sink {
            list.views.forEach { $0.removeFromSuperview() }
            counter.stringValue = formatter.string(from: .init(value: $0.count))! + .key("Counter")
            guard !$0.isEmpty else { return }
            var top = list.top
            $0.map(Article.init(_:)).forEach {
                $0.target = self
                $0.action = #selector(self.click(_:))
                (top == list.top ? [$0] : [Separator(), $0]).forEach {
                    list.add($0)
                    $0.topAnchor.constraint(equalTo: top).isActive = true
                    $0.leftAnchor.constraint(equalTo: list.left).isActive = true
                    $0.rightAnchor.constraint(equalTo: list.right).isActive = true
                    top = $0.bottomAnchor
                }
            }
            list.bottom.constraint(greaterThanOrEqualTo: top).isActive = true
        }
    }
    
    override func close() {
        NSApp.terminate(nil)
    }
    
    @objc private func click(_ article: Article) {
        list.views.compactMap { $0 as? Article }.forEach {
            if article == $0 {
                $0.selected = true
            } else if $0.selected {
                $0.selected = false
            }
        }
        content.views.forEach { $0.removeFromSuperview() }
        let detail = Detail(article.item)
        content.add(detail)
        
        detail.topAnchor.constraint(equalTo: content.top).isActive = true
        detail.leftAnchor.constraint(equalTo: content.left).isActive = true
        detail.rightAnchor.constraint(equalTo: content.right).isActive = true
        content.bottom.constraint(greaterThanOrEqualTo: detail.bottomAnchor).isActive = true
        
//        article.item.status = .read
//        news.balam.update(article.item)
//        article.update()
//        NSWorkspace.shared.open(article.item.link)
    }
}
