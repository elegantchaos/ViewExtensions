// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/01/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if targetEnvironment(macCatalyst) || !os(macOS)
import UIKit

/// Subclass of `PopoverButton` which shows a menu in a popover.
/// The menu consists of a vertical stack of items presented in a table.
/// If not all items will fit in the available space, the table will scroll.

@available(iOS 13.0, *) open class PopoverMenuButton: PopoverButton {
    public typealias SelectionBlock = (MenuItem) -> ()

    let label: String?
    let spacing: CGFloat

    class ItemTable: UITableViewController {
        let button: PopoverMenuButton!
        var padding = CGFloat(0)

        init(button: PopoverMenuButton, label: String? = nil) {
            self.button = button
            super.init(style: .plain)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "item")
            tableView.separatorStyle = .none
            tableView.rowHeight = 32.0
            
            if let label = label {
                let stack = UIStackView(axis: .horizontal)
                stack.isLayoutMarginsRelativeArrangement = true
                stack.directionalLayoutMargins.leading = button.spacing
                stack.directionalLayoutMargins.top = button.spacing
                let header = UILabel()
                header.isEnabled = false
                header.text = label
                header.sizeToFit()
                header.font = UIFont.preferredFont(forTextStyle: .footnote)
                stack.addArrangedSubview(header)
                stack.bounds.size.height = header.bounds.size.height + stack.directionalLayoutMargins.top
                padding = stack.bounds.size.height
                tableView.tableHeaderView = stack
            }
        }
        
        required init?(coder: NSCoder) {
            self.button = nil
            super.init(coder: coder)
        }

        override var preferredContentSize: CGSize {
            get {
                let itemCount = self.tableView(tableView, numberOfRowsInSection: 0)
                let height = padding + (CGFloat(itemCount) * tableView.rowHeight)
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

    public init(systemIconName: String, label: String? = nil, spacing: CGFloat = 8.0) {
        self.label = label
        self.spacing = spacing
        super.init(systemIconName: systemIconName)
    }
    
    public required init?(coder: NSCoder) {
        self.label = nil
        self.spacing = 0
        super.init(coder: coder)
    }
    
    open override func constructView() -> UIViewController {
        return ItemTable(button: self, label: self.label)
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
#endif
