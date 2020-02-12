import XCTest
@testable import ViewExtensions

#if canImport(UIKit)
import UIKit
#endif

final class ViewExtensionsTests: XCTestCase {
    func testFindViewController() {
        #if canImport(UIKit)
        let vc = UIViewController()
        let view1 = UIView()
        let view2 = UIView()
        vc.view.addSubview(view1)
        view1.addSubview(view2)
        let found = view2.findViewController()
        XCTAssertTrue(found === vc)
        #endif
    }
}
