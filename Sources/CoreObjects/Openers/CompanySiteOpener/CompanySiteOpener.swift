//
//  CompanySiteOpener.swift
//  
//
//  Created by Алексей Филиппов on 16.09.2023.
//

// Apple
import Foundation

public protocol CompanySiteOpener: URLOpener {
    var companySitePageProvider: CompanySitePageProvider { get }
    
    func openLicencePage()
    func openTermsOfUsagePage()
    func openPrivacyPolicyPage()
}

public extension CompanySiteOpener {
    // MARK: - MovaviSiteOpening
    func openLicencePage() {
        openURL(companySitePageProvider.licencePage)
    }
    
    func openTermsOfUsagePage() {
        openURL(companySitePageProvider.termsOfUsage)
    }
    
    func openPrivacyPolicyPage() {
        openURL(companySitePageProvider.privacyPolicy)
    }
}

public protocol CompanySitePageProvider: AnyObject {
    var licencePage: URL { get }
    var termsOfUsage: URL { get }
    var privacyPolicy: URL { get }
}
