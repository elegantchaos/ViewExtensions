// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 13/01/2020.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import UIKit

public class EnhancedTableView: UITableView {
    public var selfSizing = true
    public var dynamicHeaderSize = true
    public var dynamicFooterSize = true

    public override func didMoveToSuperview() {
        if selfSizing {
            isScrollEnabled = false
        }
        
        super.didMoveToSuperview()
    }
    
    public override func layoutSubviews() {
        if dynamicHeaderSize, let header = tableHeaderView {
            let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            if header.frame.size.height != size.height {
                header.frame.size.height = size.height
            }
        }

        if dynamicFooterSize, let footer = tableFooterView {
            let size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            if footer.frame.size.height != size.height {
                footer.frame.size.height = size.height
            }
        }

        super.layoutSubviews()
    }

    public override var intrinsicContentSize: CGSize {
        return selfSizing ? contentSize : super.intrinsicContentSize
    }
    
}
