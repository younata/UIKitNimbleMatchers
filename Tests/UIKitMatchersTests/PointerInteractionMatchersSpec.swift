#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

@available(iOS 13.4, *)
final class TestPointerHelper: QuickSpec {
    override class func spec() {
        describe("haveTheDefaultPointerInteraction") {
            describe("for views") {
                it("fails when the view is nil") {
                    let view: UIView? = nil

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beFalse())
                }

                it("does not match when the view has no interactions at all") {
                    let view = UIView()
                    expect(view.interactions).to(beEmpty())

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("does not match when the view has only non-pointer interactions") {
                    let view = UIView()
                    view.addInteraction(UIPencilInteraction())

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("matches when the user has the default pointer interaction") {
                    let view = UIView()
                    view.addInteraction(UIPointerInteraction())

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beTrue())
                    expect(records.last?.success).to(beFalse())
                }

                it("does not match if the user has multiple pointer interactions") {
                    let view = UIView()
                    view.addInteraction(UIPointerInteraction())
                    view.addInteraction(UIPointerInteraction())

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("does not match if the user has a custom pointer interaction") {
                    class PointerDelegate: NSObject, UIPointerInteractionDelegate {
                        // I'm not going to bother asserting on what this does yet.
                    }

                    let view = UIView()
                    let delegate = PointerDelegate()
                    view.addInteraction(UIPointerInteraction(delegate: delegate))

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("does not match if the user uses a button") {
                    let button = UIButton()

                    button.addInteraction(UIPointerInteraction())

                    let records = gatherExpectations(silently: true) {
                        expect(button).to(haveTheDefaultPointerInteraction())
                        expect(button).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }
            }

            describe("for buttons") {
                it("fails when the button is nil") {
                    let button: UIButton? = nil

                    let records = gatherExpectations(silently: true) {
                        expect(button).to(haveTheDefaultPointerInteraction())
                        expect(button).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beFalse())
                }

                it("does not match when the button's isPointerInteractionEnabled is false") {
                    let button = UIButton()
                    button.isPointerInteractionEnabled = false

                    let records = gatherExpectations(silently: true) {
                        expect(button).to(haveTheDefaultPointerInteraction())
                        expect(button).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("matches when the button's isPointerInteractionEnabled is true") {
                    let button = UIButton()
                    button.isPointerInteractionEnabled = true

                    let records = gatherExpectations(silently: true) {
                        expect(button).to(haveTheDefaultPointerInteraction())
                        expect(button).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beTrue())
                    expect(records.last?.success).to(beFalse())
                }

                it("does not match if the button has pointerStyleProvider set to something non-nil") {
                    let button = UIButton()
                    button.isPointerInteractionEnabled = true
                    button.pointerStyleProvider = { (button, _, _) in return UIPointerStyle(effect: .automatic(UITargetedPreview(view: button))) }

                    let records = gatherExpectations(silently: true) {
                        expect(button).to(haveTheDefaultPointerInteraction())
                        expect(button).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("does not match when the user adds a single UIPointerInteraction with no delegate") {
                    let button = UIButton()
                    button.addInteraction(UIPointerInteraction())

                    let records = gatherExpectations(silently: true) {
                        expect(button).to(haveTheDefaultPointerInteraction())
                        expect(button).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("does not match when the user adds a single UIPointerInteraction with no delegate") {
                    let button = UIButton()
                    button.isPointerInteractionEnabled = true
                    button.addInteraction(UIPointerInteraction())

                    let records = gatherExpectations(silently: true) {
                        expect(button).to(haveTheDefaultPointerInteraction())
                        expect(button).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("does not match if the user has multiple pointer interactions") {
                    let view = UIView()
                    view.addInteraction(UIPointerInteraction())
                    view.addInteraction(UIPointerInteraction())

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }

                it("does not match if the user has a custom pointer interaction") {
                    class PointerDelegate: NSObject, UIPointerInteractionDelegate {
                        // I'm not going to bother asserting on what this does yet.
                    }

                    let view = UIView()
                    let delegate = PointerDelegate()
                    view.addInteraction(UIPointerInteraction(delegate: delegate))

                    let records = gatherExpectations(silently: true) {
                        expect(view).to(haveTheDefaultPointerInteraction())
                        expect(view).toNot(haveTheDefaultPointerInteraction())
                    }

                    expect(records).to(haveCount(2))
                    expect(records.first?.success).to(beFalse())
                    expect(records.last?.success).to(beTrue())
                }
            }
        }
    }
}

#endif
