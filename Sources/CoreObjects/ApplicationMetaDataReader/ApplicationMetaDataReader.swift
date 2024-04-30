//
//  ApplicationMetaDataReader.swift
//
//
//  Created by Алексей Филиппов on 31.03.2024.
//

// Apple
import Foundation

public protocol ApplicationMetaDataReader {
    static func applicationShortVersion(bundle: Bundle) -> String?
    static func applicationName(bundle: Bundle) -> String?
    static func applicationBundleName(bundle: Bundle) -> String
}

public extension ApplicationMetaDataReader {
    static func applicationShortVersion(bundle: Bundle) -> String? {
        bundle.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static func applicationName(bundle: Bundle) -> String? {
        bundle.infoDictionary?["CFBundleName"] as? String
    }
    
    static func applicationBundleName(bundle: Bundle) -> String? {
        bundle.bundleIdentifier
    }
}
