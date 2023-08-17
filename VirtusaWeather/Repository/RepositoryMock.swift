//
//  RepositoryMock.swift
//  VirtusaWeather
//
//  Created by Hector Bautista on 16/08/23.
//

import Combine
import Foundation

final class RepositoryMock: RepositoryContract {
    func fetch<T: Codable>(_ city: String) -> AnyPublisher<T, Error> {
        let typeName = String(describing: T.self)
        let filePath = Bundle.main.path(forResource: typeName, ofType: "json")
        let url = URL(fileURLWithPath: filePath ?? "")
        let jsonDecoder = JSONDecoder()

        guard let data = try? Data(contentsOf: url),
              let json = try? jsonDecoder.decode(T.self, from: data) else {
            fatalError("JSON not found")
        }
        
        return Future { promise in
            promise(.success(json))
        }.eraseToAnyPublisher()
    }
}
