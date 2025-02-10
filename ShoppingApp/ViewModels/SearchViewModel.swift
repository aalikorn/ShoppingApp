//
//  SearchVieModel.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//


import Foundation

final class SearchViewModel {
    private let repository = ProductRepository()
    
    var products: [Product] = []
    var onUpdate: (() -> Void)?

    func loadProducts() {
        repository.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.onUpdate?()
            case .failure(let error):
                print("Ошибка загрузки: \(error)")
            }
        }
    }
    
    func getPhoto(_ url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        repository.fetchPhoto(url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Ошибка загрузки фото: \(error)")
                completion(.failure(error))
            }
        }
    }
}
