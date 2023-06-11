#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

private final class EnablementMatcherBehavior<T: Enablable>: Behavior<(Bool) -> T> {
    override class func spec(_ aContext: @escaping () -> (Bool) -> T) {
        var factory: ((Bool) -> T)!

        beforeEach {
            factory = aContext()
        }

        describe("\(T.self)") {
            it("matches when the object is enabled") {
                let object = factory(true)
                let results = gatherExpectations(silently: true) {
                    expect(object).to(beEnabled()) // pass
                    expect(object).toNot(beEnabled()) // fail
                }
                expect(results).to(haveCount(2))
                expect(results.first?.success).to(beTrue())
                expect(results.last?.success).to(beFalse())
            }

            it("does not match when the object is disabled") {
                let object = factory(false)
                let results = gatherExpectations(silently: true) {
                    expect(object).to(beEnabled()) // fail
                    expect(object).toNot(beEnabled()) // pass
                }
                expect(results).to(haveCount(2))
                expect(results.first?.success).to(beFalse())
                expect(results.last?.success).to(beTrue())
            }

            it("fails always when the object is nil") {
                let object: T? = nil

                let results = gatherExpectations(silently: true) {
                    expect(object).to(beEnabled()) // fail
                    expect(object).toNot(beEnabled()) // fail
                }
                expect(results).to(haveCount(2))
                expect(results.first?.success).to(beFalse())
                expect(results.last?.success).to(beFalse())
            }
        }
    }
}

final class BeEnabledSpec: QuickSpec {
    override class func spec() {
        itBehavesLike(EnablementMatcherBehavior.self) {
            { enabled -> UIControl in
                let control = UIControl()
                control.isEnabled = enabled
                return control
            }
        }

        itBehavesLike(EnablementMatcherBehavior.self) {
            { enabled -> UIAlertAction in
                let action = UIAlertAction()
                action.isEnabled = enabled
                return action
            }
        }

        itBehavesLike(EnablementMatcherBehavior.self) {
            { enabled -> UIBarButtonItem in
                let action = UIBarButtonItem()
                action.isEnabled = enabled
                return action
            }
        }
    }
}

#endif
