//
//  APIService.swift
//  ConcurrencyDemo
//
//  Created by eric on 2022-03-04.
//

import Foundation

// this a reuseable service class
struct APIService {
    
    // need to provide the url during initization
    let urlString: String
    
    func getJSON<T: Decodable>(
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      completion(.failure(.invalidResponseStatus))
                      return
                  }
            
            guard error == nil else {
                completion(.failure(.dataTaskError))
                return
                
            }
            
            guard let data = data else {
                completion(.failure(.corruptData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch  {
                print("Error")
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}

enum APIError: Error{
    case invalidURL
    case invalidResponseStatus
    case dataTaskError
    case corruptData
    case decodingError
}
