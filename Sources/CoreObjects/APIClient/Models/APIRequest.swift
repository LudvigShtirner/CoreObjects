//
//  APIRequest.swift
//  
//
//  Created by Алексей Филиппов on 22.03.2023.
//

// Apple
import Foundation

public class APIRequest {
    // MARK: - Data
    private let baseURL: String
    public let httpMethod: String
    private let endpoint: String
    private let pathComponents: [String]
    private let queryParams: [URLQueryItem]
    
    // MARK: - Inits
    public init(baseURL: String,
                httpMethod: String,
                endpoint: String,
                pathComponents: [String] = [],
                queryParams: [URLQueryItem] = []) {
        self.baseURL = baseURL
        self.httpMethod = httpMethod
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParams = queryParams
    }
    
    // MARK: - Interface methods
    public var url: URL? {
        URL(string: urlString)
    }
    
    // MARK: - Private methods
    private var urlString: String {
        var string = "\(baseURL)/\(endpoint)"
        for pathComponent in pathComponents {
            string += "/\(pathComponent)"
        }
        if queryParams.isEmpty == false {
            let arguments = queryParams
                .compactMap {
                    guard let value = $0.value else { return nil }
                    return "\($0.name)=\(value)"
                }
                .joined(separator: "&")
            string += "?\(arguments)"
        }
        return string
    }
}

public class APIFixedRequest: APIRequest {
    // MARK: - Data
    private let _url: URL
    
    // MARK: - Inits
    public init(url: URL) {
        self._url = url
        super.init(baseURL: "", httpMethod: "GET", endpoint: "")
    }
    
    // MARK: - Interface methods
    public override var url: URL? {
        _url
    }
}
