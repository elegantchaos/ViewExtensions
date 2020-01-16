// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 15/01/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import UIKit

@available(iOS 13.0, *) open class PopoverButton: UIButton {
    public typealias ViewConstructor = () -> UIViewController
    
    let viewConstructor: ViewConstructor?
    let systemIconName: String?
    
    public init(viewConstructor: @escaping ViewConstructor, systemIconName: String? = nil) {
        self.viewConstructor = viewConstructor
        self.systemIconName = systemIconName
        super.init(frame: .zero)
        updateIcon()
        addTarget(self, action: #selector(doTapped(_:)), for: .primaryActionTriggered)
    }
    
    public required init?(coder: NSCoder) {
        viewConstructor = nil
        systemIconName = nil
        super.init(coder: coder)
    }
    
    func updateIcon() {
        if let name = systemIconName {
            setImage(UIImage(systemName: name), for: .normal)
        }
    }
    
    @IBAction func doTapped(_ sender: Any) {
        if let content = viewConstructor?() {
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
