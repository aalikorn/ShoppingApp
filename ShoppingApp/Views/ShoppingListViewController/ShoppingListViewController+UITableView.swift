//
//  ShoppingListViewController+UITableView.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import UIKit

extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath) as! ShoppingListItemCell
        let item = ShoppingListViewModel.shared.shoppingList[indexPath.section]
        var image: UIImage?
        if let imageURL = item.product.images.first {
            searchViewModel.getPhoto(imageURL) { result in
                switch result {
                    case .success(let data):
                        image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.configure(image: image, title: item.product.title, price: item.product.price, quantity: item.quantity)
                        }
                    case .failure(let error):
                        print("Ошибка загрузки фото в корзине: \(error)")
                        image = UIImage(named: "placeholder")
                        DispatchQueue.main.async {
                            cell.configure(image: image, title: item.product.title, price: item.product.price, quantity: item.quantity)
                        }
                    }
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ShoppingListViewModel.shared.shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = ItemViewController()
        itemVC.itemViewModel = ItemViewModel(product: ShoppingListViewModel.shared.shoppingList[indexPath.section].product)
        navigationController?.pushViewController(itemVC, animated: true)
    }
    
    
}
