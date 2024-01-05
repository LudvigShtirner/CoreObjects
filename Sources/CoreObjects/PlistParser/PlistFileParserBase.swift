//
//  PlistFileParserBase.swift
//  
//
//  Created by Алексей Филиппов on 03.12.2023.
//

// Apple
import Foundation

final class PlistFileParserBase: PlistFileParser {
    // MARK: - Inits
    init() {}
    
    // MARK: - Interface methods
    func parse<Value: Codable>(file: PlistFileParserSource) -> Value? {
        guard let rawData = try? file.parse() else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(Value.self, from: rawData)
    }
}

private extension PlistFileParserSource {
    func parse() throws -> Data {
        switch self {
        case .infoPlist(let bundle):
            guard let infoDict = bundle.infoDictionary else {
                throw PlistParserError.fileNotFound
            }
            return try JSONSerialization.data(withJSONObject: infoDict)
        case .plist(let filename, let bundle):
            guard let path = bundle.path(forResource: filename, ofType: "plist") else {
                throw PlistParserError.fileNotFound
            }
            return try Data(contentsOf: URL(fileURLWithPath: path))
        }
    }
}
