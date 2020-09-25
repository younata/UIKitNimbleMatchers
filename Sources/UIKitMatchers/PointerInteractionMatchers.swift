#if canImport(UIKit)
import UIKit
import Nimble

@available(iOS 13.4, *)
public func haveTheDefaultPointerInteraction() -> Predicate<UIView> {
    return Predicate { actual -> PredicateResult in
        let message = ExpectationMessage.expectedActualValueTo("have the default pointer interaction")
        guard let view = try actual.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }
        if view is UIButton {
            return PredicateResult(status: .doesNotMatch, message: message.appended(details: "set `isPointerInteractionEnabled` to true to support the default pointer interaction on buttons"))
        }
        let pointerInteractions = view.interactions.compactMap { $0 as? UIPointerInteraction }

        // there should be one and only one pointer interaction here.
        guard let interaction = pointerInteractions.first, pointerInteractions.count == 1 else {
            return PredicateResult(status: .doesNotMatch, message: message)
        }
        // I mean, sure, it's possible to test that the delegate's responses returns the expected default values.
        // But that's work I don't care to do, and, honestly, if you're going to THAT much effort just for the default behavior
        // Then you did something wrong and your test SHOULD fail.
        return PredicateResult(bool: interaction.delegate == nil, message: message)
    }
}

@available(iOS 13.4, *)
public func haveTheDefaultPointerInteraction() -> Predicate<UIButton> {
    return Predicate { actual -> PredicateResult in
        let message = ExpectationMessage.expectedActualValueTo("have the default pointer interaction")
        guard let button = try actual.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        let pointerInteractions = button.interactions.compactMap { $0 as? UIPointerInteraction }

        // there should be one and only one pointer interaction here.
        guard pointerInteractions.count == 1 else { // isPointerInteractionEnabled will add it's own UIPointerInteraction. This is still distinct from you the developer adding your own pointer interaction.
            return PredicateResult(status: .doesNotMatch, message: message.appended(details: "On buttons, it's easier to set `isPointerInteractionEnabled` to true. Use that for the default pointer interaction."))
        }
        // I mean, sure, it's possible to test that the pointerStyleProvider's responses returns the expected default values.
        // But that's work I don't care to do, and, honestly, if you're going to THAT much effort just for the default behavior
        // Then you did something wrong and your test SHOULD fail.
        return PredicateResult(bool: button.isPointerInteractionEnabled == true && button.pointerStyleProvider == nil, message: message)
    }
}
#endif
