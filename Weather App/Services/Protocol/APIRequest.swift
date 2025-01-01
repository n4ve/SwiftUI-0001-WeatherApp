//
//  ApiRequest.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//
import Foundation
import Combine


protocol APIRequest {
    associatedtype ResponseType: Decodable
    
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    func body() throws -> Data?
}

extension APIRequest {
    
    var session: URLSession {
        URLSession.shared
    }
    
    var backgroundQueue: DispatchQueue {
        DispatchQueue.global(qos: .background)
    }
    
}
