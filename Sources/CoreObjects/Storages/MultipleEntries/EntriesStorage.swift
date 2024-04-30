//
//  EntriesStorage.swift
//  
//
//  Created by Алексей Филиппов on 08.03.2023.
//

// SPM
import SupportCode
// Apple
import Foundation

public protocol EntriesAsyncStorage: AnyObject {
    associatedtype StoredType
    
    func obtainAll() async -> [StoredType]
    func obtain(with predicate: @escaping (StoredType) -> Bool) async -> StoredType?
    func store(_ model: StoredType) async
    func remove(with predicate: @escaping (StoredType) -> Bool) async
    func clear() async
}

public protocol EntriesStorage: AnyObject {
    associatedtype StoredType
    
    func obtainAll() -> [StoredType]
    func obtain(with predicate: @escaping (StoredType) -> Bool) -> StoredType?
    func store(_ model: StoredType)
    func remove(with predicate: @escaping (StoredType) -> Bool)
    func clear()
}
 
