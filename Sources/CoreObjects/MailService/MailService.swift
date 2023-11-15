//
//  MailService.swift
//  
//
//  Created by Алексей Филиппов on 13.08.2023.
//

// Apple
import Foundation

public protocol MailService: AnyObject {
    func canSendMail() -> Bool
}
