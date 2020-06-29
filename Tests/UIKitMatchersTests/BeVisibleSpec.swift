#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

final class BeVisibleSpec: QuickSpec {
    override func spec() {
        func itVerifiesWhenAViewIsVisible(_ factory: @escaping () -> (child: UIView, parent: UIView)) {
            it("it shows the view when it's non-hidden, non-transparent, with non-zero size") {
                let (child, parent) = factory()

                let records = gatherExpectations(silently: true) {
                    expect(child).to(beVisible(insideOf: parent)) // true
                    expect(child).toNot(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when it's hidden") {
                let (child, parent) = factory()

                child.isHidden = true

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when the parent is hidden") {
                let (child, parent) = factory()

                parent.isHidden = true

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when it's alpha is 0") {
                let (child, parent) = factory()

                child.alpha = 0

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when the parent's alpha is 0'") {
                let (child, parent) = factory()

                parent.alpha = 0

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when it's width is 0") {
                let (child, parent) = factory()

                child.frame = CGRect(x: 0, y: 0, width: 0, height: 10)

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when the parent's width is 0'") {
                let (child, parent) = factory()

                parent.frame = CGRect(x: 0, y: 0, width: 0, height: 10)

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when it's height is 0") {
                let (child, parent) = factory()

                child.frame = CGRect(x: 0, y: 0, width: 10, height: 0)

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }

            it("does not show the child view when the parent's height is 0'") {
                let (child, parent) = factory()

                parent.frame = CGRect(x: 0, y: 0, width: 10, height: 0)

                let records = gatherExpectations(silently: true) {
                    expect(child).toNot(beVisible(insideOf: parent)) // true
                    expect(child).to(beVisible(insideOf: parent)) // false
                }

                expect(records).to(haveCount(2))
                expect(records.first?.success).to(beTrue())
                expect(records.last?.success).to(beFalse())
            }
        }

        describe("verifying views alone") {
            itVerifiesWhenAViewIsVisible {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))

                return (view, view)
            }
        }

        describe("verifying a view hierarchy") {
            itVerifiesWhenAViewIsVisible {
                let child = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                let parent = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))

                parent.addSubview(child)

                return (child, parent)
            }
        }
    }
}

#endif
