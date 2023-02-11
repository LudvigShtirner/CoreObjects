//
//  SettingsAppOpener.swift
//  
//
//  Created by Алексей Филиппов on 20.01.2023.
//

/// Протокол роутера приложения настроек
protocol SettingsAppOpener: AnyObject {
    /// Открыть настройки приложения (доступы к фото, камере и т.д.)
    func openAppSettings()
}
