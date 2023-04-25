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
    
    func obtainAll(completion: @escaping ResultBlock<[StoredType]>)
    func obtain(with predicate: @escaping (StoredType) -> Bool,
                completion: @escaping ResultBlock<[StoredType]>)
    func store(_ model: StoredType,
               completion: @escaping ResultBlock<Void>)
    func clear(completion: @escaping ResultBlock<Void>)
}

public protocol EntriesStorage: AnyObject {
    associatedtype StoredType
    
    func obtainAll() -> [StoredType]
    func obtain(with predicate: @escaping (StoredType) -> Bool) -> [StoredType]
    func store(_ model: StoredType)
    func clear()
}
 
