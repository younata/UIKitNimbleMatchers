#if canImport(UIKit)

import UIKit
import Nimble

public func haveImage(_ image: UIImage?) -> Predicate<UIImageView> {
    return Predicate { received in
        guard let expectedImage = image else {
            return PredicateResult(status: .fail, message: ExpectationMessage.fail("Expected image was nil"))
        }
        let message = ExpectationMessage.expectedActualValueTo("have image '\(expectedImage)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view.image == expectedImage, message: message.appended(details: "got '\(String(describing: view.image))'"))
    }
}

public func haveImage() -> Predicate<UIImageView> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have any image")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view.image != nil, message: message.appended(details: "got '\(String(describing: view.image))'"))
    }
}

public func haveImage(_ image: UIImage?, for state: UIControl.State = .normal) -> Predicate<UIButton> {
    return Predicate { received in
        guard let expectedImage = image else {
            return PredicateResult(status: .fail, message: ExpectationMessage.fail("Expected image was nil"))
        }
        let message = ExpectationMessage.expectedActualValueTo("have image '\(expectedImage)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let receivedImage = view.image(for: state)
        return PredicateResult(bool: receivedImage == expectedImage, message: message.appended(details: "got '\(String(describing: receivedImage))'"))
    }
}

public func haveImage(for state: UIControl.State = .normal) -> Predicate<UIButton> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have any image")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let receivedImage = view.image(for: state)
        return PredicateResult(bool: receivedImage != nil, message: message.appended(details: "got '\(String(describing: receivedImage))'"))
    }
}

#endif
