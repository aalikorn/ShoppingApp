//
//  FiltersViewModel.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 15.02.2025.
//

import Foundation

class FiltersViewModel {
    var name: String?
    var price: Double?
    var minPrice: Double?
    var maxPrice: Double?
    var category: String?
    
    static let shared = FiltersViewModel()
    private init() {}
    
    func filtersToURLParam() -> String {
        var param = ""
        if let name = name {
            param += "title=\(name)&"
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
                param += "categoryId=2&"
            case "Мебель":
                param += "categoryId=3&"
            case "Одежда":
                param += "categoryId=1&"
            case "Обувь":
                param += "categoryId=4&"
            case "Разное":
                param += "categoryId=5&"
            default:
                break
            }
        }
        return param
    }
}
