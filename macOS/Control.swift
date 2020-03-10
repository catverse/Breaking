import AppKit

class Control: NSView {
    weak var target: AnyObject!
    var click: Selector!
    override var mouseDownCanMoveWindow: Bool { false }
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setAccessibilityElement(true)
        setAccessibilityRole(.button)
        addTrackingArea(.init(rect: .zero, options: [.mouseEnteredAndExited, .activeInActiveApp, .inVisibleRect], owner: self))
    }
    
    override func resetCursorRects() {
        addCursorRect(bounds, cursor: .pointingHand)
    }
    
    override func mouseExited(with: NSEvent) {
        hoverOff()
    }
    
    func hoverOn() {
        alphaValue = 0.3
    }
    
    func hoverOff() {
        alphaValue = 1
    }
}
