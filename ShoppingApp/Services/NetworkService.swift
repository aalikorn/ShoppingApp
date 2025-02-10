//
//  NetworkService.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Decodable>(_ urlRequest: URLRequest,
                               completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func requestData(_ urlRequest: URLRequest,
                         completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
}
