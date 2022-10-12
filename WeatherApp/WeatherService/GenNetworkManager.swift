//
//  GenNetworkManager.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 12/10/2022.
//

import Foundation

extension URLSession {
    
    enum NetworkError: Error {
        case invalidUrl
        case dataNotFound
        case parsingFailed
    }
    func request<T: Decodable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>)-> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        let task = dataTask(with: url) {data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.dataNotFound))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.parsingFailed))
            }
        }
        task.resume()
    }
}
