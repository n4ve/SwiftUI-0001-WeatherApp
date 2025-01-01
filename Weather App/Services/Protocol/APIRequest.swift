//
//  ApiRequest.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//
import Foundation
import Combine


protocol APIRequest {
    associatedtype RequestModel: Decodable
    
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    func body() throws -> Data?
}

extension APIRequest {
    func buildRequest(baseURL: String) throws -> URLRequest {
        
        guard let url = URL(string: baseURL + path) else {
            throw APIServiceError.invalidURL
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}
