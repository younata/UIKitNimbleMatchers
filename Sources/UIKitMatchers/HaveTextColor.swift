#if canImport(UIKit)
import UIKit
import Nimble

public func haveTextColor(_ color: UIColor) -> Predicate<TextDisplayer> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have text color '\(color)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view._textColor == color, message: message.appended(details: "got '\(String(describing: view._textColor))'"))
    }
}

public func haveTextColor(_ color: UIColor, for state: UIControl.State = .normal) -> Predicate<UIButton> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have text color '\(color)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let receivedColor = view.titleColor(for: state)
        return PredicateResult(bool: receivedColor == color, message: message.appended(details: "got '\(String(describing: receivedColor))'"))
    }
}

#endif
