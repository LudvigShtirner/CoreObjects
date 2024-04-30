//
//  MailServiceMock.swift
//
//
//  Created by Алексей Филиппов on 27.02.2024.
//

/// SPM
import CoreObjects
/// Apple
import Foundation

public final class MailServiceMock: MailService {
    public init() { }
    
    public var canSendMailHandler: (() -> Bool)?
    public func canSendMail() -> Bool {
        canSendMailHandler!()
    }
}
