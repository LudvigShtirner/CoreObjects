//
//  PlistFileParser.swift
//  
//
//  Created by Алексей Филиппов on 12.09.2023.
//

// Apple
import Foundation

public protocol PlistFileParser: AnyObject {
    func parse<Value: Codable>(file: PlistFileParserSource) -> Value? 
}

public enum PlistFileParserSource {
    case infoPlist(_: Bundle)
    case plist(_: String, _: Bundle)
}

enum PlistParserError: Error {
    case fileNotFound
}
