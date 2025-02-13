//
//  ShoppingListViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import UIKit

class ShoppingListViewController: UIViewController {
    var shoppingListTableView: UITableView!
    var shoppingListViewModel: ShoppingListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        shoppingListViewModel = ShoppingListViewModel()
        setupShoppingListTableView()
    }
    
    func setupShoppingListTableView() {
        shoppingListTableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(shoppingListTableView)
        shoppingListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.shoppingListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.self .shoppingListTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.shoppingListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.shoppingListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
    }
}
