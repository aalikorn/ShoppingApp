//
//  ShoppingListViewModel.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import Foundation

class ShoppingListViewModel {
    static let shared = ShoppingListViewModel()
    private init() {}
    
    var onUpdate: (() -> Void)?

    var shoppingList: [ShoppingListItem] = []

    func loadShoppingList() {
        shoppingList = DataManager.shared.fetchShoppingList()
    }

    func addProduct(_ product: Product) {
        DataManager.shared.addProductToCart(product, quantity: 1)
        loadShoppingList()
        onUpdate?()
    }

    func updateQuantity(for product: Product, newQuantity: Int) {
        if newQuantity > 0 {
            DataManager.shared.changeQuantity(for: product, newQuantity: newQuantity)
        } else {
            DataManager.shared.removeProductFromCart(product)
        }
        loadShoppingList()
        onUpdate?()
    }

    func removeProduct(_ product: Product) {
        DataManager.shared.removeProductFromCart(product)
        loadShoppingList()
        onUpdate?()
    }
}

