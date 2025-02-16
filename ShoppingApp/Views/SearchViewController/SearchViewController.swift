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
    
    var isFetchingMoreProducts = false
    
    var notFoundView: UIView!
    var errorView: UIView!
    
    let historyTableView = UITableView()
    var historyHeightAnchor = NSLayoutConstraint()
    var filteredHistory: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        view.backgroundColor = .white
        setupKeyboardDismissRecognizer()
        setupCollectionView()
        setupErrorView()
        setupNotFoundView()
        setupHistoryTableView()
        SearchViewModel.shared.onUpdate = {[weak self] in
            self?.updateUI()}
        SearchViewModel.shared.loadProducts()
        SearchViewModel.shared.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.errorView.isHidden = false
                self?.collectionView.isHidden = true
            }
        }
        addTapGestureToHideHistory()
        
    }
    
    func setupNotFoundView() {
        notFoundView = UIView(frame: .zero)
        view.addSubview(notFoundView)
        notFoundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notFoundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            notFoundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            notFoundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            notFoundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        let label = UILabel()

        notFoundView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: notFoundView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: notFoundView.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        label.text = "По такому запросу ничего не найдено :("
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        notFoundView.isHidden = true
    }
    
    func setupErrorView() {
        errorView = UIView(frame: .zero)
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        let label = UILabel()
        let button = UIButton(type: .system)
        
        errorView.addSubview(label)
        errorView.addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: errorView.centerYAnchor, constant: -50),
            label.widthAnchor.constraint(equalToConstant: 250),
            
            button.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: errorView.centerYAnchor, constant: 50),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        label.text = "Произошла ошибка при обработке запроса :("
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        button.setTitle("Попробовать снова", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        
        errorView.isHidden = true
    }
    
    @objc func tryAgainButtonTapped() {
        SearchViewModel.shared.repeatQuery()
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
        if SearchViewModel.shared.products.isEmpty {
            notFoundView.isHidden = false
            collectionView.isHidden = true
        } else {
            notFoundView.isHidden = true
            collectionView.isHidden = false
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
       
        present(filterVC, animated: true)
    }
    
    private func addTapGestureToHideHistory() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSearchHistory))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideSearchHistory() {
        historyTableView.isHidden = true
    }

}

