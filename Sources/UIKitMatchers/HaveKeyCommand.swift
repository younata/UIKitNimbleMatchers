#if canImport(UIKit)
import UIKit
import Nimble
import Foundation

@available(iOS 13.0, *)
public func haveKeyCommand(input: String?, modifiers: UIKeyModifierFlags = [], title: String, discoverabilityTitle: String, image: UIImage? = nil, attributes: UIMenuElement.Attributes = [], state: UIMenuElement.State = .on) -> Nimble.Predicate<UIResponder> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedTo("have key command (input: \(inputString(input: input, modifiers: modifiers)), title: \(title), discoverabilityTitle: \(discoverabilityTitle), image: \(String(describing: image)), attributes: \(attributes), state: \(state))")

        guard let responder = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        guard let keyCommands = responder.keyCommands, keyCommands.isEmpty == false else {
            return PredicateResult(status: .doesNotMatch, message: message.appended(details: "Found no key commands"))
        }

        let commandExists: Bool = keyCommands.contains { (command: UIKeyCommand) -> Bool in
            return command.input == input &&
                command.modifierFlags == modifiers &&
                command.title == title &&
                command.discoverabilityTitle == discoverabilityTitle &&
                command.image == image &&
                command.attributes == attributes &&
                command.state == state &&
                command.propertyList == nil &&
                command.alternates.isEmpty
        }

        let commandNames = keyCommands.map { (command: UIKeyCommand) -> String in
            return "(input: \(inputString(input: command.input, modifiers: command.modifierFlags)), title: \(command.title), discoverabilityTitle: \(String(describing: command.discoverabilityTitle)), image: \(String(describing: command.image)), attributes: \(command.attributes), state: \(command.state), propertyList: \(String(describing: command.propertyList)), alternates: \(command.alternates))"
        }.joined(separator: ",\n")

        return PredicateResult(bool: commandExists, message: message.appended(details: "Found [\(commandNames)]"))
    }
}

@available(iOS 13.0, *)
public func haveKeyCommand(input: String?, modifiers: UIKeyModifierFlags = [], title: String, image: UIImage? = nil, attributes: UIMenuElement.Attributes = [], state: UIMenuElement.State = .on) -> Nimble.Predicate<UIResponder> {
    return haveKeyCommand(input: input, modifiers: modifiers, title: title, discoverabilityTitle: title, image: image, attributes: attributes, state: state)
}

@available(iOS 13.0, *)
public func containKeyCommand(input: String?, modifiers: UIKeyModifierFlags = [], title: String, image: UIImage? = nil) -> Nimble.Predicate<[UIKeyCommand]> {
    return Nimble.Predicate { received in
        let message = ExpectationMessage.expectedTo("have key command (input: \(inputString(input: input, modifiers: modifiers)), title: \(title), discoverabilityTitle: \(title), image: \(String(describing: image)), attributes: [], state: .on)")

        guard let keyCommands = try received.evaluate() else {
            return PredicateResult(status: .fail, message: message.appendedBeNilHint())
        }

        guard keyCommands.isEmpty == false else {
            return PredicateResult(status: .doesNotMatch, message: message.appended(details: "Found no key commands"))
        }

        let commandExists: Bool = keyCommands.contains { (command: UIKeyCommand) -> Bool in
            return command.input == input &&
                command.modifierFlags == modifiers &&
                command.title == title &&
                command.discoverabilityTitle == title &&
                command.image == image &&
                command.attributes == [] &&
                command.state == .on &&
                command.propertyList == nil &&
                command.alternates.isEmpty
        }

        let commandNames = keyCommands.map { (command: UIKeyCommand) -> String in
            return "(input: \(inputString(input: command.input, modifiers: command.modifierFlags)), title: \(command.title), discoverabilityTitle: \(String(describing: command.discoverabilityTitle)), image: \(String(describing: command.image)), attributes: \(command.attributes), state: \(command.state), propertyList: \(String(describing: command.propertyList)), alternates: \(command.alternates))"
        }.joined(separator: ",\n")

        return PredicateResult(bool: commandExists, message: message.appended(details: "Found [\(commandNames)]"))
    }
}

private func inputString(input: String?, modifiers: UIKeyModifierFlags) -> String {
    return [modifiers.description, input].compactMap { (str: String?) -> String? in
        guard str?.isEmpty == false else { return nil }
        return str
    }.joined(separator: "+")
}

extension UIKeyModifierFlags: CustomStringConvertible {
    public var description: String {
        var flags: [String] = []
        if self.contains(.command) {
            flags.append("cmd")
        }
        if self.contains(.alternate) {
            flags.append("opt")
        }
        if self.contains(.shift) {
            flags.append("shift")
        }
        if self.contains(.alphaShift) {
            flags.append("caps lock")
        }
        if self.contains(.numericPad) {
            flags.append("numpad")
        }
        if self.contains(.control) {
            flags.append("ctrl")
        }

        return flags.joined(separator: "+")
    }
}

#endif
