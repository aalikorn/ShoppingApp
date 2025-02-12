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
    var currentPage = 1
    private let itemsPerPage = 20
    private var isLoading = false

    func loadProducts(title: String? = nil) {
        guard !isLoading else { return }
        isLoading = true
        repository.fetchProducts(offset: (currentPage - 1) * itemsPerPage, limit: itemsPerPage,title: title) { [weak self] result in
            switch result {
            case .success(let newProducts):
                if self?.currentPage == 1 {
                    self?.products.removeAll()
                }
                self?.isLoading = false
                self?.products.append(contentsOf: newProducts)
                self?.currentPage += 1
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
