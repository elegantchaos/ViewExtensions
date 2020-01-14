// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 14/01/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import UIKit

public extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
    }
}
