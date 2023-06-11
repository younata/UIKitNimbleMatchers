#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

@available(iOS 13.0, *) // only because I don't want to ship with an image asset to test with.
final class HaveImageSpec: QuickSpec {
    override class func spec() {
        let image = UIImage(systemName: "photo")
        let otherImage = UIImage(systemName: "photo.fill")

        describe("image views") {
            var subject: UIImageView!

            beforeEach {
                subject = UIImageView()
            }

            it("matches when the imageView has the expected image") {
                subject.image = image

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveImage(image)) // pass
                    expect(subject).to(haveImage(otherImage))
                    expect(subject).toNot(haveImage(image)) // fail
                }

                expect(results).to(haveCount(3))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
                expect(results[2].success).to(beFalse())
            }

            it("matches if the imageView has an image and we expect any image") {
                subject.image = image

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveImage()) // pass
                    expect(subject).toNot(haveImage()) // fail
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
            }

            it("doesn't match if the imageView doesn't have an image and we expect any image") {
                subject.image = nil

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveImage()) // fail
                    expect(subject).toNot(haveImage()) // pass
                    expect(subject).to(haveImage(otherImage)) // fail
                }

                expect(results).to(haveCount(3))
                expect(results[0].success).to(beFalse())
                expect(results[1].success).to(beTrue())
                expect(results[2].success).to(beFalse())
            }
        }

        describe("buttons") {
            var subject: UIButton!


            beforeEach {
                subject = UIButton()
            }

            it("matches when the button has the expected image") {
                subject.setImage(image, for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveImage(image)) // pass
                    expect(subject).to(haveImage(otherImage))
                    expect(subject).toNot(haveImage(image)) // fail
                }

                expect(results).to(haveCount(3))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
                expect(results[2].success).to(beFalse())
            }

            it("matches if the button has an image and we expect any image") {
                subject.setImage(image, for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveImage()) // pass
                    expect(subject).toNot(haveImage()) // fail
                }

                expect(results).to(haveCount(2))
                expect(results[0].success).to(beTrue())
                expect(results[1].success).to(beFalse())
            }

            it("doesn't match if the button doesn't have an image and we expect any image") {
                subject.setImage(nil, for: .normal)

                let results = gatherExpectations(silently: true) {
                    expect(subject).to(haveImage()) // fail
                    expect(subject).toNot(haveImage()) // pass
                    expect(subject).to(haveImage(otherImage)) // fail
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
