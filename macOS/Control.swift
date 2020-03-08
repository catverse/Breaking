import AppKit

class Control: NSView {
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
    
    override func mouseDown(with: NSEvent) {
        hoverOn()
    }
    
    override func mouseExited(with: NSEvent) {
        hoverOff()
    }
    
    override func mouseUp(with: NSEvent) {
        window!.makeFirstResponder(self)
        if bounds.contains(convert(with.locationInWindow, from: nil)) {
            click()
        } else {
            super.mouseUp(with: with)
        }
        hoverOff()
    }
    
    func hoverOn() {
        alphaValue = 0.3
    }
    
    func hoverOff() {
        alphaValue = 1
    }
    
    func click() {
        
    }
}
