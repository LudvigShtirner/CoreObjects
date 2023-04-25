//
//  SingleEntryStorage.swift
//  
//
//  Created by Алексей Филиппов on 08.03.2023.
//

// Apple
import Foundation

protocol SingleEntryStorage: AnyObject {
    associatedtype StoredType
    func obtain() -> StoredType?
    func store(_ entry: StoredType)
    func clear()
}
