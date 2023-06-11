#if canImport(UIKit)
import UIKit
import Nimble

public protocol TextDisplayer {
    var _text: String? { get }
    var _textColor: UIColor? { get }
}

extension UILabel: TextDisplayer {
    public var _text: String? { return self.text }
    public var _textColor: UIColor? { return self.textColor }
}
extension UITextField: TextDisplayer {
    public var _text: String? { return self.text }
    public var _textColor: UIColor? { return self.textColor }
}
extension UITextView: TextDisplayer {
    public var _text: String? { return self.text }
    public var _textColor: UIColor? { return self.textColor }
}

public func displayText(_ text: String) -> Nimble.Predicate<TextDisplayer> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have text '\(text)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view._text == text, message: message.appended(details: "got '\(String(describing: view._text))'"))
    }
}

public func displayText() -> Nimble.Predicate<TextDisplayer> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have any text")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: (view._text ?? "").isEmpty == false, message: message.appended(details: "got '\(String(describing: view._text))'"))
    }
}

public func displayPlaceholder(_ string: String) -> Nimble.Predicate<UITextField> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have text '\(string)'")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: view.placeholder == string, message: message.appended(details: "got '\(String(describing: view.placeholder))'"))
    }
}

public func displayText(_ text: String, for state: UIControl.State = .normal) -> Nimble.Predicate<UIButton> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have title '\(text)' for state \(state)")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let title = view.title(for: state)
        return PredicateResult(bool: title == text, message: message.appended(details: "got '\(String(describing: title))'"))
    }
}

public func displayText(for state: UIControl.State = .normal) -> Nimble.Predicate<UIButton> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("have any title for state \(state)")

        guard let view = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let title = view.title(for: state)
        return PredicateResult(bool: (title ?? "").isEmpty == false, message: message.appended(details: "got '\(String(describing: title))'"))
    }
}

#endif
