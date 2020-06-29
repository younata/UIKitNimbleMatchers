#if canImport(UIKit)
import Quick
import UIKit
import Nimble
import UIKitMatchers

@available(iOS 13.0, *)
final class HaveKeyCommandSpec: QuickSpec {
    override func spec() {
        it("does not match when the object doesn't have any key commands") {
            let object = TestResponder()

            let results = gatherExpectations(silently: true) {
                expect(object).to(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // fail
                expect(object).toNot(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // pass
            }

            expect(results).to(haveCount(2))
            expect(results.first?.success).to(beFalse())
            expect(results.last?.success).to(beTrue())
        }

        it("does not match when the object doesn't have the specified key command") {
            let object = TestResponder()

            object._keyCommands = [
                UIKeyCommand(input: "f", modifierFlags: .control, action: #selector(TestResponder.doNothing))
            ]

            let results = gatherExpectations(silently: true) {
                expect(object).to(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // fail
                expect(object).toNot(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // pass
            }

            expect(results).to(haveCount(2))
            expect(results.first?.success).to(beFalse())
            expect(results.last?.success).to(beTrue())
        }

        it("does not match when the object's key command doesn't exactly follow all the given parameters") {
            let object = TestResponder()

            object._keyCommands = [
                UIKeyCommand(input: "e", modifierFlags: .command, action: #selector(TestResponder.doNothing))
            ]

            let results = gatherExpectations(silently: true) {
                expect(object).to(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // fail
                expect(object).toNot(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // pass
            }

            expect(results).to(haveCount(2))
            expect(results.first?.success).to(beFalse())
            expect(results.last?.success).to(beTrue())
        }

        it("matches when the exact key command is found") {
            let object = TestResponder()

            object._keyCommands = [
                UIKeyCommand(title: "hello", image: nil, action: #selector(TestResponder.doNothing), input: "e", modifierFlags: .command, propertyList: nil, alternates: [], discoverabilityTitle: "world", attributes: [], state: .on)
            ]

            let results = gatherExpectations(silently: true) {
                expect(object).to(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // pass
                expect(object).toNot(haveKeyCommand(input: "e", modifiers: .command, title: "hello", discoverabilityTitle: "world")) // fail
            }

            expect(results).to(haveCount(2))
            expect(results.first?.success).to(beTrue())
            expect(results.last?.success).to(beFalse())
        }
    }
}

class TestResponder: UIResponder {
    var _keyCommands: [UIKeyCommand]? = nil

    override var keyCommands: [UIKeyCommand]? { return _keyCommands }

    @objc func doNothing() {}
}

#endif
