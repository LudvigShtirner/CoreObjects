//
//  NotificationCenterListener.swift
//  CoreObjects
//
//  Created by Алексей Филиппов on 22.04.2022.
//

// SPM
import SupportCode

/// Протокол слушателя нотификации от системы
public protocol NotificationCenterListener: AnyObject {
    /// Добавить наблюдателя за слушателем в виде замыкания
    /// - Returns: Уникальный ключ наблюдателя
    func addListener(_ closure: @escaping VoidBlock) -> String
    /// Удалить наблюдателя по ключу
    func removeListener(forKey key: String)
}
