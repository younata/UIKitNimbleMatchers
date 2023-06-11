#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

final class HaveTextColorSpec: QuickSpec {
    override class func spec() {
        func itBehavesLikeATextColorDisplayer(_ subjectFactory: @escaping (UIColor) -> TextDisplayer) {
            it("matches when the textColor has the expected color") {
                let subject = subjectFactory(.blue)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveTextColor(UIColor.blue)) // pass
                    expect(subject).to(haveTextColor(UIColor.red)) // fail
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
            }

            it("does not match when the textColor doesn't have the expected color") {
                let subject = subjectFactory(.blue)

                let results = gatherExpectations(silently: true) {
                    expect(subject).toNot(haveTextColor(UIColor.red)) // pass
                    expect(subject).toNot(haveTextColor(UIColor.blue)) // fail
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
            }
        }

        describe("UILabel") {
            itBehavesLikeATextColorDisplayer {
                let subject = UILabel()
                subject.textColor = $0
                return subject
            }
        }

        describe("UITextField") {
            itBehavesLikeATextColorDisplayer {
                let subject = UITextField()
                subject.textColor = $0
                return subject
            }
        }

        describe("UITextView") {
            itBehavesLikeATextColorDisplayer {
                let subject = UITextView()
                subject.textColor = $0
                return subject
            }
        }

        describe("UIButton") {
            it("matches when the title color for normal has the expected color") {
                let subject = UIButton()

                subject.setTitleColor(.blue, for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveTextColor(UIColor.blue)) // pass
                    expect(subject).to(haveTextColor(UIColor.red)) // fail
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
            }

            it("matches for the title color of that state") {
                let subject = UIButton()

                subject.setTitleColor(.blue, for: .normal)
                subject.setTitleColor(.gray, for: .disabled)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveTextColor(UIColor.gray, for: .disabled)) // pass
                    expect(subject).to(haveTextColor(UIColor.blue)) // true
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beTrue())
            }

            it("does not match when the title color for normal doesn't have the expected color") {
                let subject = UIButton()

                subject.setTitleColor(.blue, for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).toNot(haveTextColor(UIColor.red)) // pass
                    expect(subject).toNot(haveTextColor(UIColor.blue)) // fail
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
            }
        }
    }
}
#endif
