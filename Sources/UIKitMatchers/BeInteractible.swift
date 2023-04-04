#if canImport(UIKit)
import UIKit
import Nimble

public func beInteractible(insideOf containingView: UIView) -> Predicate<UIView> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("be interactible")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }
        guard try beVisible(insideOf: containingView).satisfies(received).status == .matches else {
            return PredicateResult(bool: false, message: message)
        }

        return PredicateResult(bool: view.isInteractible(), message: message)
    }
}

public func beInteractible(insideOf viewController: UIViewController) -> Predicate<UIView> {
    return beInteractible(insideOf: viewController.view)
}

private extension UIView {
    func isInteractible() -> Bool {
        guard areParentsInteractible() else {
            return false
        }
        return self.frame.size.height >= 44 && self.frame.size.width >= 44
    }

    func areParentsInteractible() -> Bool {
        guard self.isUserInteractionEnabled == true else {
            return false
        }
        if let superview = self.superview {
            return superview.areParentsInteractible()
        }
        return true
    }
}
#endif
