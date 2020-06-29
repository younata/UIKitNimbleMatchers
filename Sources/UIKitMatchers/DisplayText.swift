#if canImport(UIKit)
import UIKit
import Nimble

public protocol TextDisplayer {
    var text: String? { get }
}

extension UILabel: TextDisplayer {}
extension UITextField: TextDisplayer {}

public func displayText(_ text: String) -> Predicate<TextDisplayer> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have text '\(text)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view.text == text, message: message.appended(details: "got '\(String(describing: view.text))'"))
    }
}

public func displayText() -> Predicate<TextDisplayer> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have any text")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: (view.text ?? "").isEmpty == false, message: message.appended(details: "got '\(String(describing: view.text))'"))
    }
}

public func displayPlaceholder(_ string: String) -> Predicate<UITextField> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have text '\(string)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view.placeholder == string, message: message.appended(details: "got '\(String(describing: view.placeholder))'"))
    }
}

public func displayText(_ text: String, for state: UIControl.State = .normal) -> Predicate<UIButton> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have title '\(text)' for state \(state)")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let title = view.title(for: state)
        return PredicateResult(bool: title == text, message: message.appended(details: "got '\(String(describing: title))'"))
    }
}

public func displayText(for state: UIControl.State = .normal) -> Predicate<UIButton> {
    return Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have any title for state \(state)")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let title = view.title(for: state)
        return PredicateResult(bool: (title ?? "").isEmpty == false, message: message.appended(details: "got '\(String(describing: title))'"))
    }
}

#endif
