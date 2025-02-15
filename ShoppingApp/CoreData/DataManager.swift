//
//  DataManager.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    
    func fetchShoppingList() -> [ShoppingListItem] {
        let request: NSFetchRequest<ShoppingListItemEntity> = ShoppingListItemEntity.fetchRequest()
        
        do {
            var shoppingList: [ShoppingListItem] = []
            let items = try context.fetch(request)
            for item in items {
                guard let productEntity = item.product else {
                    print("Ошибка")
                    continue
                }
                let category = Category(id: Int(productEntity.category!.id), name: productEntity.category!.name!, image: productEntity.category!.image!)
                let product = Product(id: Int(productEntity.id), title: productEntity.title!, price: productEntity.price, description: productEntity.productDescription!, category: category, images: [productEntity.image!])
                let shoppingListItem = ShoppingListItem(product: product, quantity: Int(item.quantity))
                shoppingList.append(shoppingListItem)
            }
            return shoppingList
        } catch {
            print("Ошибка загрузки корзины: \(error)")
            return []
        }
    }

    func addProductToCart(_ product: Product, quantity: Int) {
        let request: NSFetchRequest<ShoppingListItemEntity> = ShoppingListItemEntity.fetchRequest()
        print(type(of: product.id))
        request.predicate = NSPredicate(format: "productID == %lld", Int64(product.id))
        
        do {
            let existingItems = try context.fetch(request)
            
            if let existingItem = existingItems.first {

                existingItem.quantity += Int64(quantity)
            } else {

                let newItem = ShoppingListItemEntity(context: context)
                newItem.quantity = Int64(quantity)
                
                let productEntity = ProductEntity(context: context)
                productEntity.id = Int64(product.id)
                productEntity.title = product.title
                productEntity.price = product.price
                productEntity.productDescription = product.description
                productEntity.image = product.images.first
                let newCategory = ProductCategory(context: context)
                newCategory.id = Int64(product.category.id)
                newCategory.name = product.category.name
                newCategory.image = product.category.image
                productEntity.category = newCategory
                
                newItem.product = productEntity
                newItem.productID = Int64(product.id)
            }
            try context.save()
        } catch {
            print("Ошибка при добавлении товара: \(error)")
        }
    }

    func getQuantity(for product: Product) -> Int? {
        let request: NSFetchRequest<ShoppingListItemEntity> = ShoppingListItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "productID == %lld", Int64(product.id))

        do {
            let existingItems = try context.fetch(request)
            
            if let existingItem = existingItems.first {
                return Int(existingItem.quantity)
            }
        } catch {
            print("Ошибка при получении товара \(error)")
        }
        return nil
    }
    
    func changeQuantity(for product: Product, newQuantity: Int) {
        let request: NSFetchRequest<ShoppingListItemEntity> = ShoppingListItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "productID == %lld", Int64(product.id))

        do {
            let existingItems = try context.fetch(request)
            
            if let existingItem = existingItems.first {
                if newQuantity > 0 {
                    existingItem.quantity = Int64(newQuantity)
                } else {
                    context.delete(existingItem)
                }
                try context.save()
            }
        } catch {
            print("Ошибка при изменении количества: \(error)")
        }
    }

    func removeProductFromCart(_ product: Product) {
        let request: NSFetchRequest<ShoppingListItemEntity> = ShoppingListItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "productID == %lld", Int64(product.id))

        do {
            let existingItems = try context.fetch(request)
            
            if let existingItem = existingItems.first {
                context.delete(existingItem)
                try context.save()
            }
        } catch {
            print("Ошибка при удалении товара: \(error)")
        }
    }
}

