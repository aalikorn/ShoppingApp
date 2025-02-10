//
//  Product.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let images: [String]
}

struct Category: Codable {
    let id: Int
    let name: String
    let image: String
}
