#if canImport(UIKit)
import UIKit
import Nimble
import Foundation

public func beAnAccessibilityElement() -> Nimble.Predicate<NSObject> {
    return Nimble.Predicate { received in

        guard let item = try received.evaluate() else {
            return PredicateResult(status: .fail, message: ExpectationMessage.expectedTo("be an accessibility element").appendedBeNilHint())
        }
        let message = ExpectationMessage.expectedCustomValueTo("be an accessibility element", actual: "isAccessibilityElement: \(item.isAccessibilityElement)")

        return PredicateResult(bool: item.isAccessibilityElement, message: message)
    }
}

public func haveAccessibilityLabel(_ label: String) -> Nimble.Predicate<NSObject> {
    return Nimble.Predicate { received in
        let rawMessage = "have accessibility label '\(label)'"

        guard let item = try received.evaluate() else {
            return PredicateResult(status: .fail, message: ExpectationMessage.expectedTo(rawMessage).appendedBeNilHint())
        }
        let message = ExpectationMessage.expectedCustomValueTo("have accessibility label '\(label)'", actual: item.accessibilityLabel ?? "<nil>")

        guard item.isAccessibilityElement == true else {
            return PredicateResult(status: .fail, message: message.appended(details: "Not an accessibility element"))
        }


        return PredicateResult(bool: item.accessibilityLabel == label, message: message.appended(details: "Got '\(String(describing: item.accessibilityLabel))'"))
    }
}

public func haveAccessibilityTraits(_ traits: UIAccessibilityTraits) -> Nimble.Predicate<NSObject> {
    return Nimble.Predicate { received in
        let rawMessage = "have accessibility traits '\(traits)'"

        guard let item = try received.evaluate() else {
            return PredicateResult(status: .fail, message: ExpectationMessage.expectedTo(rawMessage).appendedBeNilHint())
        }
        let message = ExpectationMessage.expectedCustomValueTo(rawMessage, actual: item.accessibilityTraits.description)

        if traits.contains(.tabBar) {
            guard item.isAccessibilityElement == false else {
                return PredicateResult(status: .fail, message: message.appended(details: "TabBars must not be accessibility elements"))
            }
        } else {
            guard item.isAccessibilityElement == true else {
                return PredicateResult(status: .fail, message: message.appended(details: "Not an accessibility element"))
            }
        }

        return PredicateResult(bool: item.accessibilityTraits == traits, message: message.appended(details: "Got '\(item.accessibilityTraits)'"))
    }
}

public func haveAccessibilityValue(_ value: String) -> Nimble.Predicate<NSObject> {
    return Nimble.Predicate { received in
        let rawMessage = "have accessibility value '\(value)'"

        guard let item = try received.evaluate() else {
            return PredicateResult(status: .fail, message: ExpectationMessage.expectedTo(rawMessage).appendedBeNilHint())
        }

        let message = ExpectationMessage.expectedCustomValueTo(rawMessage, actual: item.accessibilityValue ?? "<nil>")

        guard item.isAccessibilityElement == true else {
            return PredicateResult(status: .fail, message: message.appended(details: "Not an accessibility element"))
        }

        return PredicateResult(bool: item.accessibilityValue == value, message: message.appended(details: "Got '\(String(describing: item.accessibilityValue))'"))
    }
}

public func haveAccessibilityHint(_ hint: String) -> Nimble.Predicate<NSObject> {
    return Nimble.Predicate { received in
        let rawMessage = "have accessibility hint '\(hint)'"

        guard let item = try received.evaluate() else {
            return PredicateResult(status: .fail, message: ExpectationMessage.expectedTo(rawMessage).appendedBeNilHint())
        }

        let message = ExpectationMessage.expectedCustomValueTo(rawMessage, actual: item.accessibilityHint ?? "<nil>")

        guard item.isAccessibilityElement == true else {
            return PredicateResult(status: .fail, message: message.appended(details: "Not an accessibility element"))
        }

        return PredicateResult(bool: item.accessibilityHint == hint, message: message.appended(details: "Got '\(String(describing: item.accessibilityHint))'"))
    }
}

extension UIAccessibilityTraits: CustomStringConvertible {
    public var description: String {
        var traits: [String] = []
        if self.contains(UIAccessibilityTraits.none) {
            traits.append("None")
        }
        if self.contains(UIAccessibilityTraits.button) {
            traits.append("Button")
        }
        if self.contains(UIAccessibilityTraits.link) {
            traits.append("Link")
        }
        if self.contains(UIAccessibilityTraits.header) {
            traits.append("Header")
        }
        if self.contains(UIAccessibilityTraits.searchField) {
            traits.append("Search field")
        }
        if self.contains(UIAccessibilityTraits.image) {
            traits.append("Image")
        }
        if self.contains(UIAccessibilityTraits.selected) {
            traits.append("Selected")
        }
        if self.contains(UIAccessibilityTraits.playsSound) {
            traits.append("Plays sound")
        }
        if self.contains(UIAccessibilityTraits.keyboardKey) {
            traits.append("Keyboard key")
        }
        if self.contains(UIAccessibilityTraits.staticText) {
            traits.append("Static text")
        }
        if self.contains(UIAccessibilityTraits.summaryElement) {
            traits.append("Summary element")
        }
        if self.contains(UIAccessibilityTraits.notEnabled) {
            traits.append("Not enabled")
        }
        if self.contains(UIAccessibilityTraits.updatesFrequently) {
            traits.append("Updates frequently")
        }
        if self.contains(UIAccessibilityTraits.startsMediaSession) {
            traits.append("Starts media session")
        }
        if self.contains(UIAccessibilityTraits.adjustable) {
            traits.append("Adjustable")
        }
        if self.contains(UIAccessibilityTraits.allowsDirectInteraction) {
            traits.append("Allows direct interaction")
        }
        if self.contains(UIAccessibilityTraits.causesPageTurn) {
            traits.append("Causes page turn")
        }
        if self.contains(UIAccessibilityTraits.tabBar) {
            traits.append("Tab bar")
        }

        return traits.joined(separator: ", ")
    }
}
#endif
