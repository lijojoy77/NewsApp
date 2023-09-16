//
//  Webservice.swift
//  NewsApp
//
//  Created by Lijo Joy on 13/09/2023.
//

import Foundation

// Protocol for WebService
protocol WebServiceProtocol {
    func loadService<T: Decodable>(
        url: URL,
        requestMethod: String,
        completion: @escaping (Result<T, Error>) -> ()
    )
}

// Implementation of WebService
class WebService: WebServiceProtocol {
    func loadService<T: Decodable>(
        url: URL,
        requestMethod: String = "GET",
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        let config = URLSessionConfiguration.ephemeral
        config.urlCache = nil
        let session = URLSession(configuration: config)
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        
        DispatchQueue.main.async {
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    do {
                        if let data = data {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            let result = try decoder.decode(T.self, from: data)
                            completion(.success(result))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
