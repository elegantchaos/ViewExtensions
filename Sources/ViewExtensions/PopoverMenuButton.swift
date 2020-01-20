// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/01/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import UIKit

/// Subclass of `PopoverButton` which shows a menu in a popover.
/// The menu consists of a vertical stack of items presented in a table.
/// If not all items will fit in the available space, the table will scroll.

@available(iOS 13.0, *) open class PopoverMenuButton: PopoverButton {
    public typealias SelectionBlock = (MenuItem) -> ()

    class ItemTable: UITableViewController {
        let button: PopoverMenuButton!

        init(button: PopoverMenuButton) {
            self.button = button
            super.init(style: .plain)
        }
        
        required init?(coder: NSCoder) {
            self.button = nil
            super.init(coder: coder)
        }

        override var preferredContentSize: CGSize {
            get {
                let padding = CGFloat(16.0)
                let itemCount = self.tableView(tableView, numberOfRowsInSection: 0)
                let itemHeight = CGFloat(32.0)
                let height = padding + (CGFloat(itemCount + 1) * itemHeight)
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "item")
                return CGSize(width: 0, height: height)
            }
            
            set {
                super.preferredContentSize = newValue
            }
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return button.itemCount()
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "item")!
            if let item = button.item(at: indexPath.row) {
                button.configure(cell: cell, for: item)
            }
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let item = button.item(at: indexPath.row) {
                button.select(item: item)
            }
            dismiss(animated: true) {
                
            }
        }
    }

    public init(systemIconName: String) {
        super.init(systemIconName: systemIconName)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func constructView() -> UIViewController {
        return ItemTable(button: self)
    }
    
    open func itemCount() -> Int {
        return 0
    }

    open func item(at row: Int) -> Any? {
        return nil
    }

    open func configure(cell: UITableViewCell, for item: Any) {
        cell.textLabel?.text = "<item>"
    }
    
    open func select(item: Any) {
    }
}

