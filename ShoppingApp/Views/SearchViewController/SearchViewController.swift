//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import UIKit

class SearchViewController: UIViewController {
    var collectionView: UICollectionView!
    let searchController = SearchBarWithFilter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        view.backgroundColor = .white
        setupKeyboardDismissRecognizer()
        setupCollectionView()
        SearchViewModel.shared.onUpdate = {[weak self] in
            self?.updateUI()}
        SearchViewModel.shared.loadProducts()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.backgroundColor = .white

        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "\(ItemCell.self)")
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupSearchController() {
        searchController.placeholder = "Search for product..."
        self.navigationItem.titleView = searchController
        searchController.delegate = self
        searchController.filterButton.addTarget(self, action: #selector(openFilters), for: .touchUpInside)
        
    }
    
    @objc private func openFilters() {
        let filterVC = FiltersViewController()
        if let sheet = filterVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
       
        present(filterVC, animated: true)
    }
}

