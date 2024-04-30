//
//  KeyboardListener.swift
//
//
//  Created by Алексей Филиппов on 28.04.2024.
//

// SPM
import SupportCode
// Apple
import UIKit

protocol KeyboardListener: AnyObject {
    func subscribe(on event: KeyboardEventType) -> String
    @discardableResult
    func unsubscribe(with key: String) -> Bool
}

// MARK: - Subtypes
struct KeyboardAnimation {
    let keyboardFrame: CGRect
    let duration: TimeInterval
    let curve: UIView.AnimationCurve
}

enum KeyboardEventType {
    case keyboardWillShow((KeyboardAnimation) -> Void)
    case keyboardWillHide((KeyboardAnimation) -> Void)
}

