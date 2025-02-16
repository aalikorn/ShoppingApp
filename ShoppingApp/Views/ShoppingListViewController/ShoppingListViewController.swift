//
//  ShoppingListViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import UIKit

class ShoppingListViewController: UIViewController {
    var shoppingListTableView: UITableView!
    var emptyStateView: UIView!
    
    var searchViewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupShoppingListTableView()
        setupEmptyStateView()
        ShoppingListViewModel.shared.onUpdate = { [weak self] in
            self?.updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func setupEmptyStateView() {
        emptyStateView = UIView(frame: .zero)
        view.addSubview(emptyStateView)
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        let label = UILabel()
        let button = UIButton(type: .system)
        
        emptyStateView.addSubview(label)
        emptyStateView.addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor, constant: -50),
            label.widthAnchor.constraint(equalToConstant: 250),
            
            button.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor, constant: 50),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        label.text = "Ваша корзина пока что пуста :("
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        button.setTitle("К поиску товаров", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(emptyStateButtonTapped), for: .touchUpInside)
    }
    
    @objc func emptyStateButtonTapped() {
        if let tabBarController = self.tabBarController {
           tabBarController.selectedIndex = 0 
        }
        if let searchNav = tabBarController?.viewControllers?[0] as? UINavigationController {
            searchNav.popToRootViewController(animated: false) 
        }
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
            ShoppingListViewModel.shared.loadShoppingList()
            if ShoppingListViewModel.shared.shoppingList.isEmpty {
                self.shoppingListTableView.isHidden = true
                self.emptyStateView.isHidden = false
            } else {
                self.shoppingListTableView.isHidden = false
                self.emptyStateView.isHidden = true
                self.shoppingListTableView.reloadData()
            }
            
        }
    }
}
