//
//  LocalNotificationWorker.swift
//  CoreObjects
//
//  Created by Алексей Филиппов on 15.04.2022.
//

import Foundation

public protocol LocalNotificationWorker: AnyObject {
    func addNotification(at date: Date,
                         configuration: LocalNotificationModel)
    func removeAllNotifications(identifier: String)
}
