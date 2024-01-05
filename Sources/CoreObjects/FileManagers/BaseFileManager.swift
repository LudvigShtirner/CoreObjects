//
//  BaseFileManager.swift
//
//
//  Created by Алексей Филиппов on 17.12.2023.
//

// Apple
import Foundation

/// Протокол базового файлового менеджера
public protocol BaseFileManager: AnyObject {
    /// Создать папку
    func createDirectoryIfNeeded(_ directory: URL)
    /// Удалить папку
    func removeDirectory(_ directory: URL)
    /// Папка для этого менеджера
    func workDirectory() -> URL?
    
    var fileManager: FileManager { get }
    var workspaceName: String { get }
}

public extension BaseFileManager {
    func workDirectory() -> URL? {
        fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                         in: FileManager.SearchPathDomainMask.userDomainMask)
            .first?
            .appendingPathComponent(workspaceName)
    }
    
    func createDirectoryIfNeeded(_ directory: URL) {
        let path = directory.path
        if fileManager.fileExists(atPath: path) {
            return
        }
        try? fileManager.createDirectory(atPath: path,
                                         withIntermediateDirectories: true,
                                         attributes: nil)
    }
    
    func removeDirectory(_ directory: URL) {
        try? fileManager.removeItem(at: directory)
    }
}
