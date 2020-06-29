#if canImport(UIKit)
import UIKit
import Nimble
import XCTest

import UIKitMatchers

final class AccessibilityMatchersTest: XCTestCase {
    // MARK: - beAnAccessibilityElement
    func test_beAnAccessibilityElement_nonNil_isElement() {
        let item = UIView()

        item.isAccessibilityElement = true

        let results = gatherExpectations(silently: true) {
            expect(item).to(beAnAccessibilityElement()) // pass
            expect(item).toNot(beAnAccessibilityElement()) // fail
        }

        expect(results).to(haveCount(2))
        expect(results.first?.success).to(beTrue())
        expect(results.last?.success).to(beFalse())
    }

    func test_beAnAccessibilityElement_nonNil_isNotElement() {
        let item = UIView()

        item.isAccessibilityElement = false

        let results = gatherExpectations(silently: true) {
            expect(item).toNot(beAnAccessibilityElement()) // pass
            expect(item).to(beAnAccessibilityElement()) // fail
        }

        expect(results).to(haveCount(2))
        expect(results.first?.success).to(beTrue())
        expect(results.last?.success).to(beFalse())
    }

    func test_beAnAccessibilityElement_nil() {
        let item: UIResponder? = nil

        let results = gatherExpectations(silently: true) {
            expect(item).to(beAnAccessibilityElement()) // fail
            expect(item).toNot(beAnAccessibilityElement()) // fail
        }

        expect(results).to(haveCount(2))
        expect(results.first?.success).to(beFalse())
        expect(results.last?.success).to(beFalse())
    }

    // MARK: - haveAccessibilityLabel
    func test_haveAccessibilityLabel_nonNil_isElement() {
        let item = UIView()

        item.isAccessibilityElement = true
        item.accessibilityLabel = "test"

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityLabel("test")) // pass
            expect(item).toNot(haveAccessibilityLabel("test")) // fail
            expect(item).to(haveAccessibilityLabel("test ")) // fail
            expect(item).toNot(haveAccessibilityLabel("test ")) // pass
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beTrue())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beTrue())
    }

    func test_haveAccessibilityLabel_nonNil_notElement() {
        let item = UIView()

        item.isAccessibilityElement = false
        item.accessibilityLabel = "test"

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityLabel("test")) // fail
            expect(item).toNot(haveAccessibilityLabel("test")) // fail
            expect(item).to(haveAccessibilityLabel("test ")) // fail
            expect(item).toNot(haveAccessibilityLabel("test ")) // fail
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beFalse())
    }

    func test_haveAccessibilityLabel_nil() {
        let item: UIView? = nil

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityLabel("test")) // fail
            expect(item).toNot(haveAccessibilityLabel("test")) // fail
            expect(item).to(haveAccessibilityLabel("test ")) // fail
            expect(item).toNot(haveAccessibilityLabel("test ")) // fail
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beFalse())
    }

    // MARK: - haveAccessibilityTraits
    func test_haveAccessibilityTraits_nonNil_notTabBar() {
        let view = UIView()

        view.isAccessibilityElement = true

        view.accessibilityTraits = [.button, .adjustable]

        let results = gatherExpectations(silently: true) {
            expect(view).to(haveAccessibilityTraits([.button, .adjustable])) // pass
            expect(view).toNot(haveAccessibilityTraits([.button, .adjustable])) // fail
            expect(view).to(haveAccessibilityTraits(.button)) // fail
            expect(view).toNot(haveAccessibilityTraits(.button)) // pass
            expect(view).to(haveAccessibilityTraits(.adjustable)) // fail
            expect(view).toNot(haveAccessibilityTraits(.adjustable)) // pass
            expect(view).to(haveAccessibilityTraits([])) // fail
        }

        expect(results).to(haveCount(7))
        expect(results[0].success).to(beTrue())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beTrue())
        expect(results[4].success).to(beFalse())
        expect(results[5].success).to(beTrue())
        expect(results[6].success).to(beFalse())
    }

    func test_haveAccessibilityTraits_nonNil_tabBar() {
        let view = UIView()

        view.isAccessibilityElement = true

        view.accessibilityTraits = [.tabBar]

        let results = gatherExpectations(silently: true) {
            expect(view).to(haveAccessibilityTraits(.tabBar)) // fail
            expect(view).toNot(haveAccessibilityTraits(.tabBar)) // fail

            view.isAccessibilityElement = false

            expect(view).to(haveAccessibilityTraits(.tabBar)) // pass
            expect(view).toNot(haveAccessibilityTraits(.tabBar)) // fail
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())

        expect(results[2].success).to(beTrue())
        expect(results[3].success).to(beFalse())
    }

    func test_haveAccessibilityTraits_nil() {
        let view: UIView? = nil

        let results = gatherExpectations(silently: true) {
            expect(view).to(haveAccessibilityTraits([.button, .adjustable])) // fail
            expect(view).toNot(haveAccessibilityTraits([.button, .adjustable])) // fail
            expect(view).to(haveAccessibilityTraits(.button)) // fail
            expect(view).toNot(haveAccessibilityTraits(.button)) // fail
            expect(view).to(haveAccessibilityTraits(.adjustable)) // fail
            expect(view).toNot(haveAccessibilityTraits(.adjustable)) // fail
            expect(view).to(haveAccessibilityTraits([])) // fail
        }

        expect(results).to(haveCount(7))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beFalse())
        expect(results[4].success).to(beFalse())
        expect(results[5].success).to(beFalse())
        expect(results[6].success).to(beFalse())
    }

    // MARK: - haveAccessibilityValue
    func test_haveAccessibilityValue_nonNil_isElement() {
        let item = UIView()

        item.isAccessibilityElement = true
        item.accessibilityValue = "test"

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityValue("test")) // pass
            expect(item).toNot(haveAccessibilityValue("test")) // fail
            expect(item).to(haveAccessibilityValue("test ")) // fail
            expect(item).toNot(haveAccessibilityValue("test ")) // pass
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beTrue())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beTrue())
    }

    func test_haveAccessibilityValue_nonNil_notElement() {
        let item = UIView()

        item.isAccessibilityElement = false
        item.accessibilityValue = "test"

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityValue("test")) // fail
            expect(item).toNot(haveAccessibilityValue("test")) // fail
            expect(item).to(haveAccessibilityValue("test ")) // fail
            expect(item).toNot(haveAccessibilityValue("test ")) // fail
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beFalse())
    }

    func test_haveAccessibilityValue_nil() {
        let item: UIView? = nil

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityValue("test")) // fail
            expect(item).toNot(haveAccessibilityValue("test")) // fail
            expect(item).to(haveAccessibilityValue("test ")) // fail
            expect(item).toNot(haveAccessibilityValue("test ")) // fail
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beFalse())
    }

    // MARK: - haveAccessibilityHint
    func test_haveAccessibilityHint_nonNil_isElement() {
        let item = UIView()

        item.isAccessibilityElement = true
        item.accessibilityHint = "test"

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityHint("test")) // pass
            expect(item).toNot(haveAccessibilityHint("test")) // fail
            expect(item).to(haveAccessibilityHint("test ")) // fail
            expect(item).toNot(haveAccessibilityHint("test ")) // pass
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beTrue())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beTrue())
    }

    func test_haveAccessibilityHint_nonNil_notElement() {
        let item = UIView()

        item.isAccessibilityElement = false
        item.accessibilityHint = "test"

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityHint("test")) // fail
            expect(item).toNot(haveAccessibilityHint("test")) // fail
            expect(item).to(haveAccessibilityHint("test ")) // fail
            expect(item).toNot(haveAccessibilityHint("test ")) // fail
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beFalse())
    }

    func test_haveAccessibilityHint_nil() {
        let item: UIView? = nil

        let results = gatherExpectations(silently: true) {
            expect(item).to(haveAccessibilityHint("test")) // fail
            expect(item).toNot(haveAccessibilityHint("test")) // fail
            expect(item).to(haveAccessibilityHint("test ")) // fail
            expect(item).toNot(haveAccessibilityHint("test ")) // fail
        }

        expect(results).to(haveCount(4))
        expect(results[0].success).to(beFalse())
        expect(results[1].success).to(beFalse())
        expect(results[2].success).to(beFalse())
        expect(results[3].success).to(beFalse())
    }
}
#endif
