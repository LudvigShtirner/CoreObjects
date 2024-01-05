//
//  APIClient.swift
//  
//
//  Created by Алексей Филиппов on 22.03.2023.
//

// SPM
import SupportCode
// Apple
import Foundation

public protocol APIClient: AnyObject {
    func execute<T: Codable>(_ request: APIRequest,
                             completion: @escaping ResultBlock<T>)
    func execute(_ request: APIRequest,
                 completion: @escaping ResultBlock<Data>)
}

final class APIClientBase: APIClient {
    // MARK: - Dependencies
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    // MARK: - Inits
    static let shared = APIClientBase()
    
    private init() { }
    
    // MARK: - Interface methods
    public func execute<T: Codable>(_ request: APIRequest,
                                    completion: @escaping ResultBlock<T>) {
        execute(request) { [weak self] result in
            switch result {
            case Result.success(let data):
                guard let self else {
                    completion(.failure(APIClientError.deallocated))
                    return
                }
                do {
                    let result = try self.decoder.decode(T.self,
                                                         from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case Result.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func execute(_ request: APIRequest,
                        completion: @escaping ResultBlock<Data>) {
        guard let urlRequest = makeRequest(from: request) else {
            completion(.failure(APIClientError.failedtoCreateRequest))
            return
        }
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(error ?? APIClientError.failedToGetData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    // MARK: - Privtae methods
    private func makeRequest(from apiRequest: APIRequest) -> URLRequest? {
        guard let url = apiRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.httpMethod
        return request
    }
}

enum APIClientError: Error {
    case failedtoCreateRequest
    case failedToGetData
    case deallocated
}
