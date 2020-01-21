// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 15/01/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if targetEnvironment(macCatalyst) || !os(macOS)
import UIKit

/// UIButton which shows a popover when tapped.

@available(iOS 13.0, *) open class PopoverButton: UIButton {
    let systemIconName: String?
    
    public init(systemIconName: String? = nil) {
        self.systemIconName = systemIconName
        super.init(frame: .zero)
        updateIcon()
        addTarget(self, action: #selector(doTapped(_:)), for: .primaryActionTriggered)
    }
    
    public required init?(coder: NSCoder) {
        systemIconName = nil
        super.init(coder: coder)
    }
    
    open func constructView() -> UIViewController? {
        return nil
    }
    
    open func updateIcon() {
        if let name = systemIconName {
            setImage(UIImage(systemName: name), for: .normal)
        }
    }
    
    @IBAction func doTapped(_ sender: Any) {
        if let content = constructView() {
            content.modalPresentationStyle = .popover
            if let popover = content.popoverPresentationController {
                popover.delegate = self
                popover.sourceView = self
                popover.sourceRect = bounds
                popover.canOverlapSourceViewRect = true
                popover.permittedArrowDirections = [.down, .up]
                findViewController()?.present(content, animated: true) {
                }
            }
        }
    }
    
}

@available(iOS 13.0, *) extension PopoverButton: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
#endif
