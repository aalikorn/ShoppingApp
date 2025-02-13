//
//  ShoppingListViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import UIKit

class ShoppingListViewController: UIViewController {
    var shoppingListTableView: UITableView!
    var searchViewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        searchViewModel = SearchViewModel()
        setupShoppingListTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
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
        shoppingListTableView.dataSource = self
        shoppingListTableView.delegate = self
        shoppingListTableView.register(ShoppingListItemCell.self, forCellReuseIdentifier: "ShoppingListCell")
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            print("update ui")
            self.shoppingListTableView.reloadData()
        }
    }
}
