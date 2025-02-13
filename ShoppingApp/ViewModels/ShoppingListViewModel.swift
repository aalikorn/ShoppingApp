//
//  ShoppingListViewModel.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import Foundation

class ShoppingListViewModel {
    var shoppingList: [ShoppingListItem] = []
    
    func addProduct(product: Product) {
        let newItem = ShoppingListItem(product: product, quantity: 1)
        shoppingList.append(newItem)
    }
    
    func changeQuantity(for shoppingListItem: ShoppingListItem, newQuantity: Int) {
        if let index = shoppingList.firstIndex(where: { $0.product.id == shoppingListItem.product.id} ) {
            if newQuantity > 0 {
                shoppingList[index].quantity = newQuantity
            } else {
                shoppingList.remove(at: index)
            }
        }
    }
}
