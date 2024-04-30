//
//  KeyboardListenerBase.swift
//
//
//  Created by Алексей Филиппов on 28.04.2024.
//

// SPM
import SupportCode
// Apple
import UIKit

final class KeyboardListenerBase {
    // MARK: - Dependencies
    private let notificationCenter: NotificationCenter
    
    // MARK: - Data
    private var listeners: [String: NotificationCenterListener] = [:]
    
    // MARK: - Life cycle
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
}

extension KeyboardListenerBase: KeyboardListener {
    func subscribe(on event: KeyboardEventType) -> String {
        let (notification, handler) = event.notificationAndHandler
        let listener = NotificationCenterListener(notificationCenter: notificationCenter,
                                                  notification: notification) { [weak self] notification in
            guard let self,
                  let keyboardAnimation = self.extractKeyboardAnimation(from: notification) else {
                return
            }
            handler(keyboardAnimation)
        }
        let key = UUID().uuidString
        listeners[key] = listener
        return key
    }
    
    func unsubscribe(with key: String) -> Bool {
        return (listeners.removeValue(forKey: key) != nil)
    }
}

private extension KeyboardListenerBase {
    func extractKeyboardAnimation(from notification: Notification) -> KeyboardAnimation? {
        guard let userInfo = notification.userInfo,
              let cgRectWrapped = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let durationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let curveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
              let curve = UIView.AnimationCurve(rawValue: curveNumber.intValue) else {
                  return nil
              }
        return KeyboardAnimation(keyboardFrame: cgRectWrapped.cgRectValue,
                                 duration: durationNumber.doubleValue,
                                 curve: curve)
    }
}

fileprivate extension KeyboardEventType {
    var notificationAndHandler: (NSNotification.Name, ((KeyboardAnimation) -> Void)) {
        switch self {
        case .keyboardWillShow(let handler):
            return (UIResponder.keyboardWillShowNotification, handler)
        case .keyboardWillHide(let handler):
            return (UIResponder.keyboardWillHideNotification, handler)
        }
    }
}
