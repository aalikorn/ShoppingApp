//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import UIKit

class SearchViewController: UIViewController {
    var searchViewModel: SearchViewModel!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchViewModel()
        setupCollectionView()
        searchViewModel.onUpdate = {[weak self] in
            self?.updateUI()}
        searchViewModel.loadProducts()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "\(ItemCell.self)")
    }
    
    func updateUI() {
        collectionView.reloadData()
    }


}

