//
//  File.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation
import Combine

protocol APIService {
    
    var baseURL: String { get }
    
    var session: URLSession { get }
    
    var backgroundQueue: DispatchQueue { get }
    
    func execute<Request: APIRequest>(_ request: Request) -> AnyPublisher<Request.ResponseType, Error>
}

extension APIService {
    
    func createURLRequest<Request: APIRequest>(for request: Request) throws -> URLRequest {
        // Construct the full URL
        var components = URLComponents(string: baseURL + request.path)
        components?.queryItems = request.queryItems
        
        guard let url = components?.url else {
            throw APIServiceError.invalidURL
        }
        
        // Create the URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let body = try? request.body() {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
    
    func execute<Request: APIRequest>(_ request: Request) -> AnyPublisher<Request.ResponseType, Error> {
        do {
            // Construct the URLRequest
            let urlRequest = try createURLRequest(for: request)
            
            print(urlRequest)
            
            return session.dataTaskPublisher(for: urlRequest)
                .retry(1)
                .tryMap { result in
                    guard let httpResponse = result.response as? HTTPURLResponse,
                          (200..<300).contains(httpResponse.statusCode) else {
                        throw APIServiceError.httpError((result.response as? HTTPURLResponse)?.statusCode ?? -1)
                    }
                    return result.data
                }
                .decode(type: Request.ResponseType.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
}
