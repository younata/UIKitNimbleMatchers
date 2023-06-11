#if canImport(UIKit)
import UIKit
import Nimble

public func beVisible(insideOf containingView: UIView) -> Nimble.Predicate<UIView> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("be visible")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view.isVisible(insideOf: containingView), message: message)
    }
}

public func beVisible(insideOf viewController: UIViewController) -> Nimble.Predicate<UIView> {
    return beVisible(insideOf: viewController.view)
}

private extension UIView {
    func isVisible(insideOf containingView: UIView) -> Bool {
        guard isSelfVisible() else { return false }
        if self == containingView { return true }
        guard let superview = self.superview else { return false }
        return superview.isVisible(insideOf: containingView)
    }
    func isSelfVisible() -> Bool {
        return self.isHidden == false && self.alpha > 0 && self.frame.size.width > 0 && self.frame.size.height > 0
    }
}

#endif
