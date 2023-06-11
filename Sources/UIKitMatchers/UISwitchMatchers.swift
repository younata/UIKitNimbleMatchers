#if canImport(UIKit)
import UIKit
import Nimble

public protocol Switchable {
    var isOn: Bool { get }
}

extension UISwitch: Switchable {}

// MARK: - UISwitch Matchers
public func beOn() -> Nimble.Predicate<Switchable> {
    return predicateSwitchOnOrOff(inverted: false)
}

public func beOff() -> Nimble.Predicate<Switchable> {
    return predicateSwitchOnOrOff(inverted: true)
}

private func predicateSwitchOnOrOff(inverted: Bool) -> Nimble.Predicate<Switchable> {
    return Nimble.Predicate { actual in
        let message = ExpectationMessage.expectedActualValueTo("be off")
        guard let control = try actual.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }
        switch control.isOn {
        case true:
            return PredicateResult(bool: !inverted, message: message.appended(message: "Switch was on"))
        case false:
            return PredicateResult(bool: inverted, message: message.appended(message: "Switch was off"))
        }
    }
}
#endif
