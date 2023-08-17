//
//  Repository.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import Combine
import Foundation

enum AppErrors: Error {
    case invalidURL
    case invalidResponse
}

protocol RepositoryContract: AnyObject {
    func fetch<T: Codable>(_ city: String) -> AnyPublisher<T, Error>
}

class Repository: RepositoryContract {
    func fetch<T: Codable>(_ city: String) -> AnyPublisher<T, Error> {
        var components = URLComponents(string: EndPoints.base)
        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: "e31fdc37d39aa63433ae9c638834b683")
        ]
        
        guard let url = components?.url else {
            return Fail(outputType: T.self, failure: AppErrors.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in
                return AppErrors.invalidResponse
            }
            .eraseToAnyPublisher()
    }
}
