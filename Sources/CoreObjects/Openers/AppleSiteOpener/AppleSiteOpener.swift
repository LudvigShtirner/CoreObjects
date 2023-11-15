//
//  AppleSiteOpener.swift
//  
//
//  Created by Алексей Филиппов on 16.09.2023.
//

// Apple
import Foundation

public protocol AppleSiteOpener: URLOpener {
    var appleSitePageProvider: AppleSitePageProvider { get }
    
    func openSubscriptionGuide()
}

public extension AppleSiteOpener {
    func openSubscriptionGuide() {
        openURL(appleSitePageProvider.subscriptionGuideURL)
    }
}

public protocol AppleSitePageProvider: AnyObject {
    var subscriptionGuideURL: URL { get }
}
