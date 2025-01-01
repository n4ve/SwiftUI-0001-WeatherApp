//
//  File.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation
import Combine

protocol APIService {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
    func call<Request>(from request: Request) -> AnyPublisher<Request.RequestModel, Error> where Request: APIRequest
}
