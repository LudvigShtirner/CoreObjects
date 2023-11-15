//
//  AppStoreOpener.swift
//  
//
//  Created by Алексей Филиппов on 16.09.2023.
//

// Apple
import Foundation

public protocol AppStoreOpener: URLOpener {
    var appStoreIdProvider: AppStoreIdProvider { get }
    
    func openApplicationPage()
    func openApplicationReviewPage()
    func openStandartMailAppPage()
}

public extension AppStoreOpener {
    func openApplicationPage() {
        let appStoreId = appStoreIdProvider.appStoreId
        let storeURLString = String(format: "https://itunes.apple.com/app/id%@", appStoreId)
        guard let url = URL(string: storeURLString) else {
            return
        }
        openURL(url)
    }
    
    func openApplicationReviewPage() {
        let appStoreId = appStoreIdProvider.appStoreId
        let storeURLString = String(format: "https://itunes.apple.com/app/id%@?action=write-review", appStoreId)
        guard let url = URL(string: storeURLString) else {
            return
        }
        openURL(url)
    }
    
    func openStandartMailAppPage() {
        guard let url = URL(string: "https://itunes.apple.com/app/id1108187098") else {
            return
        }
        openURL(url)
    }
}

public protocol AppStoreIdProvider: AnyObject {
    var appStoreId: String { get }
}
