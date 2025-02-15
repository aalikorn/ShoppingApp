//
//  FiltersViewModel.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 15.02.2025.
//

import Foundation

class FiltersViewModel {
    var name: String?
    var price: String?
    var minPrice: Double?
    var maxPrice: Double?
    var category: String?
    
    static let shared = FiltersViewModel()
    private init() {}
    
    func filtersToURLParam() -> String {
        var param = ""
        if let name = name {
            param += "name=\(name)&"
        }
        if let price = price {
            param += "price=\(price)&"
        }
        if let minPrice = minPrice {
            param += "price_min=\(minPrice)&"
        }
        if let maxPrice = maxPrice {
            param += "price_max=\(maxPrice)&"
        }
        if let category = category {
            switch category {
            case "Электроника":
                param += "category=Electronics&"
            case "Мебель":
                param += "category=Furniture&"
            case "Одежда":
                param += "category=Clothes&"
            case "Обувь":
                param += "category=Shoes&"
            case "Разное":
                param += "category=Miscellaneous&"
            default:
                break
            }
        }
        return param
    }
}
