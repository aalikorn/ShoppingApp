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

    var shoppingList: [ShoppingListItem] = []

    func loadShoppingList() {
        shoppingList = DataManager.shared.fetchShoppingList()
    }

    func addProduct(_ product: Product) {
        DataManager.shared.addProductToCart(product, quantity: 1)
        loadShoppingList()
    }

    func updateQuantity(for product: Product, newQuantity: Int) {
        DataManager.shared.changeQuantity(for: product, newQuantity: newQuantity)
        loadShoppingList()
    }

    func removeProduct(_ product: Product) {
        DataManager.shared.removeProductFromCart(product)
        loadShoppingList()
    }
}

