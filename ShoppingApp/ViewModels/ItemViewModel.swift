//
//  ItemViewModel.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 12.02.2025.
//

import Foundation

class ItemViewModel {
    let product: Product
        
    init(product: Product) {
        self.product = product
    }
    
    var title: String {
        return product.title
    }
    
    var price: String {
        return "$\(product.price)"
    }
    
    var description: String {
        return product.description
    }
    
    var image: String {
        return product.images.first ?? ""
    }
    
    var category: String {
        return product.category.name
    }
}
