//
//  SearchVieModel.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//


import Foundation
import UIKit

final class SearchViewModel {
    private let repository = ProductRepository()
    
    var products: [Product] = []
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    var currentPage = 1
    private let itemsPerPage = 20
    private var isLoading = false
    var isReachedEndOfData: Bool = false
    
    var userDefaults = UserDefaults.standard
    var searchHistory: [String] {
        return userDefaults.array(forKey: "SearchHistory") as? [String] ?? []
    }
    
    
    static let shared = SearchViewModel()
    private init() {}
    
    var pastRequestParam: String?
    
    private var imageCache = NSCache<NSString, NSData>()
    
    func loadProducts(title: String? = nil, completion: (() -> Void)? = nil) {
        if let param = pastRequestParam {
            loadProducts(param: param)
            return
        }
        
        guard !isLoading else { return }
        isLoading = true
        self.isReachedEndOfData = false
        repository.fetchProducts(offset: (currentPage - 1) * itemsPerPage, limit: itemsPerPage,title: title) { [weak self] result in
            switch result {
            case .success(let newProducts):
                if self?.currentPage == 1 {
                    self?.products.removeAll()
                }
                self?.isLoading = false
                if newProducts.count < 20 {
                    self?.isReachedEndOfData = true
                }
                self?.products.append(contentsOf: newProducts)
                
                self?.currentPage += 1
                self?.onUpdate?()
            case .failure(let error):
                self?.onError?("Ошибка загрузки: \(error.localizedDescription)")
            }
        }
        completion?()
    }
    
    func repeatQuery() {
        if let param = pastRequestParam {
            loadProducts(param: param)
        } else {
            loadProducts()
        }
    }
    
    func loadProducts(param: String) {
        guard !isLoading else { return }
        isLoading = true
        self.isReachedEndOfData = false
        if param == "" {
            pastRequestParam = nil
        } else {
            pastRequestParam = param
        }
        repository.fetchProducts(with: param, offset: (currentPage - 1) * itemsPerPage, limit: itemsPerPage) { [weak self] result in
            switch result {
            case .success(let newProducts):
                if self?.currentPage == 1 {
                    self?.products.removeAll()
                }
                self?.isLoading = false
                if newProducts.count < 20 {
                    self?.isReachedEndOfData = true
                }
                self?.products.append(contentsOf: newProducts)
                self?.currentPage += 1
                self?.onUpdate?()
            case .failure(let error):
                self?.onError?("Ошибка загрузки: \(error.localizedDescription)")
            }
        }
    }
    
    func getPhoto(_ url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let cacheKey = NSString(string: url)
        
        if let cachedData = imageCache.object(forKey: cacheKey) {
            completion(.success(cachedData as Data))
            return
        }
        
        repository.fetchPhoto(url) { result in
            switch result {
            case .success(let data):
                self.imageCache.setObject(data as NSData, forKey: cacheKey)
                completion(.success(data))
            case .failure(let error):
                print("Ошибка загрузки фото: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func saveToHistory(_ query: String) {
        var history = searchHistory
        print(108, history)
        if history.count > 5 { history.removeLast() }
        print(110, history)
        if let index = history.firstIndex(of: query) {
            history.remove(at: index)
        }
        history.insert(query, at: 0)
        userDefaults.set(history, forKey: "SearchHistory")
    }
    
    
}
