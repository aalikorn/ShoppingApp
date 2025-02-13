//
//  ItemViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 12.02.2025.
//


import UIKit

class ItemViewController: UIViewController {
    
    var itemViewModel: ItemViewModel!
    var searchViewModel = SearchViewModel()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let addButton = UIButton()
    let categoryLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let itemViewModel = itemViewModel {
            setupImage(UIImage(named: "placeholder")!)
            configureImage(itemViewModel.image)
            configureTitleLabel(itemViewModel.title)
            configureDescriptionLabel(itemViewModel.description)
            configurePriceLabel(itemViewModel.price)
            configureCategoryLabel(itemViewModel.category)
            configureAddButton()
        }
    }
    
    func configureImage(_ url: String) {
        let imageURL = itemViewModel.image
        searchViewModel.getPhoto(imageURL) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.setupImage(image)
                    }
                }
            case .failure(let error):
                print("Ошибка загрузки фото: \(error)")
                DispatchQueue.main.async {
                    if let image = UIImage(named: "placeholder") {
                        self.setupImage(image)
                    }
                }
            }
        }
    }
    
    func setupImage(_ image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func configureTitleLabel(_ title: String) {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
    func configureDescriptionLabel(_ desc: String) {
        descriptionLabel.text = desc
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func configurePriceLabel(_ price: String) {
        priceLabel.text = price
        priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        priceLabel.textColor = .systemBlue
        view.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
    func configureCategoryLabel(_ category: String) {
        categoryLabel.text = category
        categoryLabel.font = .systemFont(ofSize: 17)
        categoryLabel.textColor = .systemBlue
        view.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func configureAddButton() {
        
    }
    
}
