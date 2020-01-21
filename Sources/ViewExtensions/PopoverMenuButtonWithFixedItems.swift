// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/01/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if targetEnvironment(macCatalyst) || !os(macOS)
import UIKit

/// Subclass of `PopoverMenuButton` which takes a fixed array of items to display.
/// The items must conform to the `MenuItem` protocol.
/// A default protocol implementation is supplied for strings.
@available(iOS 13.0, *) open class PopoverMenuButtonWithFixedItems: PopoverMenuButton {
    public typealias SelectionBlock = (MenuItem) -> ()
    let items: [MenuItem]

    public init(items: [MenuItem], systemIconName: String) {
        self.items = items
        super.init(systemIconName: systemIconName)
    }
    
    public required init?(coder: NSCoder) {
        self.items = []
        super.init(coder: coder)
    }
    
    override open func constructView() -> UIViewController {
        return ItemTable(button: self)
    }
    
    override open func item(at row: Int) -> Any? {
        guard row < items.count else { return nil }
        return items[row]
    }
    
    override open func configure(cell: UITableViewCell, for rawItem: Any) {
        if let item = rawItem as? MenuItem {
            cell.textLabel?.text = item.label(for: self)
            cell.accessoryType = item.accessoryType(for: self)
        }
    }
}

/// Protocol which items in the array must conform to.

@available(iOS 13.0, *) public protocol MenuItem {
    func label(for menu: PopoverMenuButton) -> String
    func identifier(for menu: PopoverMenuButton) -> String
    func accessoryType(for menu: PopoverMenuButton) -> UITableViewCell.AccessoryType
}

/// Menu Item protocol implementation for String.

@available(iOS 13.0, *) extension String: MenuItem {
    public func label(for menu: PopoverMenuButton) -> String { return self }
    public func identifier(for menu: PopoverMenuButton) -> String { return self }
    public func accessoryType(for menu: PopoverMenuButton) -> UITableViewCell.AccessoryType { return .none }
}
#endif
