#if canImport(UIKit)
import Quick
import UIKit
import Nimble

import UIKitMatchers

final class UIControlMatcherSpec: QuickSpec {
    override class func spec() {
        describe("UISwitch") {
            describe("beOn") {
                it("fails always when the switch is nil") {
                    let control: UISwitch? = nil

                    let results = gatherExpectations(silently: true) {
                        expect(control).to(beOn())
                        expect(control).toNot(beOn())
                    }

                    expect(results).to(haveCount(2))
                    expect(results.first?.success).to(beFalse())
                    expect(results.last?.success).to(beFalse())
                }

                it("matches when the switch is on") {
                    let control = UISwitch()
                    control.isOn = true

                    let results = gatherExpectations(silently: true) {
                        expect(control).to(beOn())
                        expect(control).toNot(beOn())
                    }

                    expect(results).to(haveCount(2))
                    expect(results.first?.success).to(beTrue())
                    expect(results.last?.success).to(beFalse())
                }

                it("does not match when the switch is off") {
                    let control = UISwitch()
                    control.isOn = false

                    let results = gatherExpectations(silently: true) {
                        expect(control).to(beOn())
                        expect(control).toNot(beOn())
                    }

                    expect(results).to(haveCount(2))
                    expect(results.first?.success).to(beFalse())
                    expect(results.last?.success).to(beTrue())
                }
            }

            describe("beOff") {
                it("fails always when the switch is nil") {
                    let control: UISwitch? = nil

                    let results = gatherExpectations(silently: true) {
                        expect(control).to(beOff())
                        expect(control).toNot(beOff())
                    }

                    expect(results).to(haveCount(2))
                    expect(results.first?.success).to(beFalse())
                    expect(results.last?.success).to(beFalse())
                }

                it("matches when the switch is off") {
                    let control = UISwitch()
                    control.isOn = true

                    let results = gatherExpectations(silently: true) {
                        expect(control).to(beOff())
                        expect(control).toNot(beOff())
                    }

                    expect(results).to(haveCount(2))
                    expect(results.first?.success).to(beFalse())
                    expect(results.last?.success).to(beTrue())
                }

                it("does not match when the switch is on") {
                    let control = UISwitch()
                    control.isOn = false

                    let results = gatherExpectations(silently: true) {
                        expect(control).to(beOff())
                        expect(control).toNot(beOff())
                    }

                    expect(results).to(haveCount(2))
                    expect(results.first?.success).to(beTrue())
                    expect(results.last?.success).to(beFalse())
                }
            }
        }
    }
}
#endif
