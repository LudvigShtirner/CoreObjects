//
//  AppLifeCycleObserverBase.swift
//  
//
//  Created by Алексей Филиппов on 28.05.2023.
//

// SPM
import SupportCode
// Apple
import UIKit

final class AppLifeCycleObserverBase: AppLifeCycleObserver {
    // MARK: - Dependencies
    private let notificationCenter: NotificationCenter
    
    // MARK: - Data
    private var listeners: [String: NotificationCenterListener] = [:]
    
    // MARK: - Life cycle
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    // MARK: - NotificationService
    func subscribeOn(_ event: AppLifeCycleEvent,
                     handler: @escaping VoidBlock) -> String {
        let notification = event.notification
        let listener = NotificationCenterListener(notificationCenter: notificationCenter,
                                                  notification: notification) { _ in
            handler()
        }
        let key = UUID().uuidString
        listeners[key] = listener
        return key
    }
    
    @discardableResult
    func unsubscribe(with key: String) -> Bool {
        return (listeners.removeValue(forKey: key) != nil)
    }
}

fileprivate extension AppLifeCycleEvent {
    var notification: NSNotification.Name {
        switch self {
        case AppLifeCycleEvent.didEnterBackground: return UIApplication.didEnterBackgroundNotification
        case AppLifeCycleEvent.willEnterForeground: return UIApplication.willEnterForegroundNotification
        case AppLifeCycleEvent.didFinishLaunching: return UIApplication.didFinishLaunchingNotification
        case AppLifeCycleEvent.didBecomeActive: return UIApplication.didBecomeActiveNotification
        case AppLifeCycleEvent.willResignActive: return UIApplication.willResignActiveNotification
        case AppLifeCycleEvent.didReceiveMemoryWarning: return UIApplication.didReceiveMemoryWarningNotification
        case AppLifeCycleEvent.willTerminate: return UIApplication.willTerminateNotification
        case AppLifeCycleEvent.significantTimeChange: return UIApplication.significantTimeChangeNotification
        case AppLifeCycleEvent.backgroundRefreshStatusDidChange: return UIApplication.backgroundRefreshStatusDidChangeNotification
        case AppLifeCycleEvent.protectedDataWillBecomeUnavailable: return UIApplication.protectedDataWillBecomeUnavailableNotification
        case AppLifeCycleEvent.protectedDataDidBecomeAvailable: return UIApplication.protectedDataDidBecomeAvailableNotification
        }
    }
}
