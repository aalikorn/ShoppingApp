//
//  ProductRepository.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import Foundation

final class ProductRepository {
    let baseURL = "https://api.escuelajs.co/api/v1"
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/products") else { return }
        let request = URLRequest(url: url)
        NetworkService.shared.request(request, completion: completion)
    }
    
    func fetchProducts(offset: Int, limit: Int, title: String? = nil, completion: @escaping (Result<[Product], Error>) -> Void) {
        var urlString: String = "\(baseURL)/products?offset=\(offset)&limit=\(limit)"
        if let title = title {
            urlString += "&title=\(title)"
        }
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        NetworkService.shared.request(request, completion: completion)
    }
    
    func fetchPhoto(_ url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let cleanedUrl = url.replacingOccurrences(of: "%5B%22", with: "")
            .replacingOccurrences(of: "%22", with: "")
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")     
            .replacingOccurrences(of: "\"", with: "")
        guard let imageUrl = URL(string: cleanedUrl) else { return }
        let request = URLRequest(url: imageUrl)
        NetworkService.shared.requestData(request, completion: completion)
    }
    
    func fetchProducts(with param: String, offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        var urlString: String = "\(baseURL)/products?offset=\(offset)&limit=\(limit)"
        urlString += "&\(param)"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        NetworkService.shared.request(request, completion: completion)
    }
}
