#if canImport(UIKit)

import UIKit
import Nimble

public protocol ImageDisplayer {
    var _image: UIImage? { get }
}

extension UIImageView: ImageDisplayer {
    public var _image: UIImage? { return self.image }
}

public func haveImage(_ image: UIImage?) -> Predicate<ImageDisplayer> {
    return Predicate { received in
        guard let expectedImage = image else {
            return PredicateResult(status: .fail, message: ExpectationMessage.fail("Expected image was nil"))
        }
        let message = ExpectationMessage.expectedActualValueTo("have image '\(expectedImage)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view._image == expectedImage, message: message.appended(details: "got '\(String(describing: view._image))'"))
    }
}

public func haveImage() -> Predicate<ImageDisplayer> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have any image")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view._image != nil, message: message.appended(details: "got '\(String(describing: view._image))'"))
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
