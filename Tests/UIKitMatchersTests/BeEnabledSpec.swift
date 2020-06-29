#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

final class BeEnabledSpec: QuickSpec {
    override func spec() {
        func itBehavesLikeAnEnablementMatcher<T: Enablable>(_ factory: @escaping (Bool) -> T, _ line: UInt = #line) {
            describe("\(T.self)") {
                it("matches when the object is enabled") {
                    let object = factory(true)
                    let results = gatherExpectations(silently: true) {
                        expect(object).to(beEnabled()) // pass
                        expect(object).toNot(beEnabled()) // fail
                    }
                    expect(results, line: line).to(haveCount(2))
                    expect(results.first?.success, line: line).to(beTrue())
                    expect(results.last?.success, line: line).to(beFalse())
                }

                it("does not match when the object is disabled") {
                    let object = factory(false)
                    let results = gatherExpectations(silently: true) {
                        expect(object).to(beEnabled()) // fail
                        expect(object).toNot(beEnabled()) // pass
                    }
                    expect(results, line: line).to(haveCount(2))
                    expect(results.first?.success, line: line).to(beFalse())
                    expect(results.last?.success, line: line).to(beTrue())
                }

                it("fails always when the object is nil") {
                    let object: T? = nil

                    let results = gatherExpectations(silently: true) {
                        expect(object).to(beEnabled()) // fail
                        expect(object).toNot(beEnabled()) // fail
                    }
                    expect(results, line: line).to(haveCount(2))
                    expect(results.first?.success, line: line).to(beFalse())
                    expect(results.last?.success, line: line).to(beFalse())
                }
            }
        }

        itBehavesLikeAnEnablementMatcher { enabled -> UIControl in
            let control = UIControl()
            control.isEnabled = enabled
            return control
        }

        itBehavesLikeAnEnablementMatcher { enabled -> UIAlertAction in
            let action = UIAlertAction()
            action.isEnabled = enabled
            return action
        }

        itBehavesLikeAnEnablementMatcher { enabled -> UIBarButtonItem in
            let action = UIBarButtonItem()
            action.isEnabled = enabled
            return action
        }
    }
}

#endif
