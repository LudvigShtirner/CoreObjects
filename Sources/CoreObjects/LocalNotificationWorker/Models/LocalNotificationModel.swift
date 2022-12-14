//
//  LocalNotificationModel.swift
//  CoreObjects
//
//  Created by Алексей Филиппов on 15.04.2022.
//

import Foundation

/// Модель локальной нотификации
public struct LocalNotificationModel {
    let typeIdentifier: String
    let title: String
    let text: String
    let userInfo: [String: Any]?
}
