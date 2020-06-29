# Nimble Matchers for UIKit

This package provides a number of [nimble](https://github.com/quick/nimble) matchers intended for verifying the state of UIKit components.

I strongly believe that unit tests should be written in a declarative manner, and while `expect(label?.text).to(equal("some value"))` works and is somewhat descriptive, it's not really declarative. I find `expect(label).to(displayText("some value"))` better conveys the intent behind the behavior being described.

Though, the real impetus that started me on this path of writing matchers is the [`beVisible`](Sources/UIKitMatchers/BeVisible.swift) matcher. The main ways to set a view as invisible are 1. set `isHidden` to true and 2. Remove it from the view hierarchy. When you're unit testing, you need to assert on the view that's actually hidden or removed (say, a container view), and you also have the test specifying the method used to make the view hidden from the user. `beVisible` combines both of those by verifying that an asserted-on `UIView` is within (or not) a given `UIView` hierarchy. There are also other ways of making a view invisible (which usually are the result of bugs) which this matcher attempts to check for.

Currently, this provides the following matchers:

- [`beAnAccessibilityElement`](Sources/UIKitMatchers/AccessibilityMatchers.swift) verifies whether the `NSObject` being asserted on has `isAccessibilityElement` set.
- [`haveAccessibilityLabel`](Sources/UIKitMatchers/AccessibilityMatchers.swift) verifies the contents of the `NSObject`'s `accessibilityLabel` property.
- [`haveAccessibilityTraits`](Sources/UIKitMatchers/AccessibilityMatchers.swift) verifies the contents of the `NSObject`'s `accessibilityTraits` property.
- [`haveAccessibilityValue`](Sources/UIKitMatchers/AccessibilityMatchers.swift) verifies the contents of the `NSObject`'s `accessibilityValue` property.
- [`haveAccessibilityHint`](Sources/UIKitMatchers/AccessibilityMatchers.swift) verifies the contents of the `NSObject`'s `accessibilityHint` property.
- [`beEnabled`](Sources/UIKitMatchers/BeEnabled.swift) verifies the contents of the `UIControl`'s, `UIAlertAction`'s, or `UIBarButton`'s `isEnabled` property. This is done with an `Enablable` property that all three of those objects conform to.
- [`beVisible`](Sources/UIKitMatchers/BeVisible.swift) verifies whether a given `UIView` is visible inside of another `UIView` hierarchy - or is shown within a `UIViewController`. Being "visible" means that the asserted-on view is within the expected view hierarchy, and that none of the views involved have: `isHidden` set to true, `alpha` set to 0, `frame.size.width` set to 0, or `frame.size.height` set to 0. It does not check to see if the view is occluded by other views, nor other ways of hiding a view from the user.
- [`displayText`](Sources/UIKitMatchers/DisplayText.swift) verifiers whether a given `UILabel`, `UITextField`, or `UIButton` has their `text` (`UILabel`/`UITextField`) set to the expected string value (using the `TextDisplayer` custom protocol) that `UILabel` and `UITextField` conform to, or the `UIButton`'s `title(for:)` method returns the expected string value for the given `UIControl.State` (defaulting to `normal).
- [`displayPlaceholder`](Sources/UIKitMatchers/DisplayText.swift) verifies that the contents of the `UITextField`'s `placeholder` property matches the given string value.
- [`haveImage`]() verifies that the `UIImageView` or `UIButton` are displaying the given `UIImage`. This works on a pointer-level comparison, and nothing particularly "smart".
- [`haveKeyCommand`](Sources/UIKitMatchers/HaveKeyCommand.swift) verifies that the `UIResponder`'s `keyCommands` property contains a `UIKeyCommand` matching the given properties.
- [`haveTheDefaultPointerInteraction`](Sources/UIKitMatchers/PointerInteractionMatchers.swift) verifies that you did the bare minimum to give the `UIView` or `UIButton` the "default" pointer interaction. What this means for `UIView` is the `interactions` property contains 1 and only 1 `UIPointerInteraction` instance, and that `UIPointerInteraction` doesn't have a delegate. For `UIButton`, it means that you did not add any `UIPointerInteraction`s, and instead you set the `isPointerInteractionEnabled` to true, and set `pointerStyleProvider` to nil.
- [`beOn`](Sources/UIKitMatchers/UISwitchMatchers.swift`) verifies that the `UISwitch`'s `isOn` property is set to `true`.
- [`beOff`](Sources/UIKitMatchers/UISwitchMatchers.swift`) verifies that the `UISwitch`'s `isOn` property is set to `false`.
