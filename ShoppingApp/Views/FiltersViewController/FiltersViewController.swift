//
//  FiltersViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

class FiltersViewController: UIViewController {
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.allowsSelection = false
        tableView.register(TitleFilterCell.self, forCellReuseIdentifier: "TitleFilterCell")
        tableView.register(ApplyCell.self, forCellReuseIdentifier: "ApplyCell")
        tableView.register(PriceFilterCell.self, forCellReuseIdentifier: "PriceFilterCell")
        tableView.register(CategoryFilterCell.self, forCellReuseIdentifier: "CategoryFilterCell")
        tableView.register(PriceRangeFilterCell.self, forCellReuseIdentifier: "PriceRangeFilterCell")
    }
    
    func closeController() {
        self.dismiss(animated: true, completion: nil)
    }
}
