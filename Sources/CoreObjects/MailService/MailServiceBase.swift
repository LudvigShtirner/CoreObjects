//
//  MailServiceBase.swift
//  
//
//  Created by Алексей Филиппов on 13.08.2023.
//

// Apple
import MessageUI

final class MailServiceBase: MailService {
    // MARK: - MailService
    func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}
