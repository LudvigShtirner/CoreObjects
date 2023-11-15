//
//  LocalNotificationWorkerBase.swift
//  CoreObjects
//
//  Created by Алексей Филиппов on 15.04.2022.
//

import class UIKit.UIApplication
import UserNotifications

final class LocalNotificationWorkerBase: LocalNotificationWorker {
    // MARK: - Dependencies
    private let application: UIApplication
    private let notificationCenter: UNUserNotificationCenter
    
    // MARK: - Data
    private let calendar = Calendar(identifier: .gregorian)
    
    // MARK: - Inits
    init(application: UIApplication = UIApplication.shared,
         notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.application = application
        self.notificationCenter = notificationCenter
    }
    
    // MARK: - LocalNotificationWorker
    func addNotification(at date: Date,
                         configuration: LocalNotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = configuration.title
        content.body = configuration.text
        content.userInfo = configuration.userInfo ?? [:]
        content.badge = NSNumber(1)
        
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone],
                                                     from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: false)
        let request = UNNotificationRequest(identifier: configuration.typeIdentifier,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    func removeAllNotifications(identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [identifier])
        application.applicationIconBadgeNumber = 0
    }
}
