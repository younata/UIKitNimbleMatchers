#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

final class DisplayTextSpec: QuickSpec {
    override func spec() {
        func itBehavesLikeATextDisplayer(_ subjectFactory: @escaping (String?) -> TextDisplayer) {
            describe("as a text displayer") {
                it("matches when the displayer has the expected text") {
                    let subject = subjectFactory("hello world")

                    let results = gatherExpectations(silently: true) {
                        expect(subject).to(displayText("hello world")) // pass
                        expect(subject).to(displayText("hello world ")) // fail, even though this is effectively what the user would see.
                        expect(subject).toNot(displayText("hello world ")) // pass, this is just to verify that it's "doesNotMatch" and not a "fail" case.
                    }

                    expect(results).to(haveCount(3))
                    expect(results[0].success).to(beTrue())
                    expect(results[1].success).to(beFalse())
                    expect(results[2].success).to(beTrue())
                }

                it("matches if the displayer has text and we expect nil text") {
                    let subject = subjectFactory("anything")

                    let results = gatherExpectations(silently: true) {
                        expect(subject).to(displayText()) // pass
                        expect(subject).toNot(displayText()) // fail
                    }

                    expect(results).to(haveCount(2))
                    expect(results[0].success).to(beTrue())
                    expect(results[1].success).to(beFalse())
                }

                it("doesn't match if the displayer doesn't have text and we expect text") {
                    let subject = subjectFactory(nil)

                    let results = gatherExpectations(silently: true) {
                        expect(subject).to(displayText()) // fail
                        expect(subject).toNot(displayText()) // pass
                        expect(subject).to(displayText("any string")) // fail
                    }

                    expect(results).to(haveCount(3))
                    expect(results[0].success).to(beFalse())
                    expect(results[1].success).to(beTrue())
                    expect(results[2].success).to(beFalse())
                }

                it("doesn't match if the displayer has empty string for text and we expect text") {
                    let subject = subjectFactory("")

                    let results = gatherExpectations(silently: true) {
                        expect(subject).to(displayText()) // fail
                        expect(subject).toNot(displayText()) // pass
                        expect(subject).to(displayText("some string")) // fail
                    }

                    expect(results).to(haveCount(3))
                    expect(results[0].success).to(beFalse())
                    expect(results[1].success).to(beTrue())
                    expect(results[2].success).to(beFalse())
                }
            }
        }

        describe("labels") {
            itBehavesLikeATextDisplayer { str in
                let subject = UILabel()
                subject.text = str
                return subject
            }
        }

        describe("textviews") {
            itBehavesLikeATextDisplayer { str in
                let subject = UITextView()
                subject.text = str
                return subject
            }
        }

        describe("textfields") {
            itBehavesLikeATextDisplayer { str in
                let textField = UITextField()
                textField.text = str
                return textField
            }

            describe("displayPlaceholder") {
                var textField: UITextField?
                beforeEach {
                    textField = UITextField()
                }

                it("matches when the textField has the expected placeholder") {
                    textField?.placeholder = "hello world"

                    let results = gatherExpectations(silently: true) {
                        expect(textField).to(displayPlaceholder("hello world")) // pass
                        expect(textField).to(displayPlaceholder("hello world ")) // fail, even though this is effectively what the user would see.
                        expect(textField).toNot(displayPlaceholder("hello world ")) // pass, this is just to verify that it's "doesNotMatch" and not a "fail" case.
                    }

                    expect(results).to(haveCount(3))
                    expect(results[0].success).to(beTrue())
                    expect(results[1].success).to(beFalse())
                    expect(results[2].success).to(beTrue())
                }
            }
        }

        describe("buttons") {
            var subject: UIButton!

            beforeEach {
                subject = UIButton()
            }

            it("matches when the button has the expected text") {
                subject.setTitle("hello world", for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(displayText("hello world")) // pass
                    expect(subject).to(displayText("hello world ")) // fail, even though this is effectively what the user would see.
                    expect(subject).toNot(displayText("hello world ")) // pass, this is just to verify that it's "doesNotMatch" and not a "fail" case.
                }

                expect(results).to(haveCount(3))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
                expect(results[2].success).to(beTrue())
            }

            it("matches if the button has text and we expect nil text") {
                subject.setTitle("anything", for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(displayText()) // pass
                    expect(subject).toNot(displayText()) // fail
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
            }

            it("doesn't match if the button doesn't have text and we expect text") {
                subject.setTitle(nil, for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(displayText()) // fail
                    expect(subject).toNot(displayText()) // pass
                    expect(subject).to(displayText("any string")) // fail
                }

                expect(results).to(haveCount(3))
                expect(results[0].success).to(beFalse())
                expect(results[1].success).to(beTrue())
                expect(results[2].success).to(beFalse())
            }

            it("doesn't match if the button has empty string for text and we expect text") {
                subject.setTitle("", for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(displayText()) // fail
                    expect(subject).toNot(displayText()) // pass
                    expect(subject).to(displayText("some string")) // fail
                }

                expect(results).to(haveCount(3))
                expect(results[0].success).to(beFalse())
                expect(results[1].success).to(beTrue())
                expect(results[2].success).to(beFalse())
            }
        }
    }
}

#endif
