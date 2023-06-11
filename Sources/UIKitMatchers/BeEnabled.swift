#if canImport(UIKit)
import UIKit
import Nimble

public protocol Enablable {
    var isEnabled: Bool { get }
}

extension UIControl: Enablable {}
extension UIAlertAction: Enablable {}
extension UIBarButtonItem: Enablable {}

public func beEnabled() -> Nimble.Predicate<Enablable> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedActualValueTo("be enabled")

        guard let object = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        return PredicateResult(bool: object.isEnabled, message: message)
    }
}
#endif
