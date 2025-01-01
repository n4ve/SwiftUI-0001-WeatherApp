//
//  WeatherAPIService.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation
import Combine

final class WeatherAPIService: APIService {
    
    let baseURL: String
    
    let session: URLSession = URLSession.shared
    
    let bgQueue: DispatchQueue = DispatchQueue.global()
    
    init(baseURL: String = "https://api.openweathermap.org/data/2.5/") {
        self.baseURL = baseURL
    }
    
    
    func call<Request>(from request: Request) -> AnyPublisher<Request.RequestModel, Error> where Request : APIRequest {
        do {
            let request = try request.buildRequest(baseURL: baseURL)
            return session.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap {
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw APIServiceError.unexpectedResponse
                    }
                    guard HTTPCodes.success.contains(code) else {
                        throw APIServiceError.httpError(code)
                    }
                    return $0.data  // Pass data to downstream publishers
                }
                .decode(type: Request.RequestModel.self, decoder: JSONDecoder())
                .mapError {_ in APIServiceError.parseError}
                .receive(on: self.bgQueue)
                .eraseToAnyPublisher()
        } catch let error {

            return Fail<Request.RequestModel, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    
}
