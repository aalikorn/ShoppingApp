//
//  ItemViewController.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 12.02.2025.
//


import UIKit

class ItemViewController: UIViewController {
    
    var itemViewModel: ItemViewModel!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let addButton = UIButton()
    let categoryLabel = UILabel()
    
    let addedToCartView = UIView()
    let quantityTextField = UITextField()
    let plusButton = UIButton()
    let minusButton = UIButton()
    let toCartButton = UIButton()
    
    let shareButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = .white
        setupScrollView()
        
        if let itemViewModel = itemViewModel {
            setupImage(UIImage(named: "placeholder")!)
            configureImage(itemViewModel.image)
            configureTitleLabel(itemViewModel.title)
            configurePriceLabel(itemViewModel.price)
            configureCategoryLabel(itemViewModel.category)
            configureAddButton()
            configureDescriptionLabel(itemViewModel.description)
            configureAddedToCartView()
        }
        configureShareButton()
        checkQuantity()
    }

    func checkQuantity() {
        if itemViewModel.quantity > 0 {
            addedToCartView.isHidden = false
            addButton.isHidden = true
        } else {
            addedToCartView.isHidden = true
            addButton.isHidden = false
        }
    }
    
    func setValueForPlaceholder() {
        quantityTextField.attributedPlaceholder = NSAttributedString(
            string: String(itemViewModel.quantity),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
    }
    
    func configureAddedToCartView() {
        
        view.addSubview(addedToCartView)
        addedToCartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addedToCartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addedToCartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addedToCartView.topAnchor.constraint(equalTo: addButton.topAnchor),
            addedToCartView.bottomAnchor.constraint(equalTo: addButton.bottomAnchor)
        ])
        

        let counterStackView = UIStackView()
        counterStackView.axis = .horizontal
        counterStackView.spacing = 8
        counterStackView.alignment = .center
        counterStackView.distribution = .equalCentering

        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .medium)
        minusButton.setTitleColor(.systemBlue, for: .normal)

        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .medium)
        plusButton.setTitleColor(.systemBlue, for: .normal)
        
        
        quantityTextField.layer.borderWidth = 1
        quantityTextField.layer.borderColor = UIColor.systemBlue.cgColor
        quantityTextField.layer.cornerRadius = 8
        quantityTextField.textAlignment = .center
        quantityTextField.isEnabled = false
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityTextField.widthAnchor.constraint(equalToConstant: 50),
            quantityTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        setValueForPlaceholder()

        counterStackView.addArrangedSubview(minusButton)
        counterStackView.addArrangedSubview(quantityTextField)
        counterStackView.addArrangedSubview(plusButton)

        let goToCartButton = UIButton()
        goToCartButton.setTitle("корзина", for: .normal)
        goToCartButton.backgroundColor = .systemBlue
        goToCartButton.layer.cornerRadius = 8
        goToCartButton.addTarget(self, action: #selector(toCartButtonTapped), for: .touchUpInside)

        addedToCartView.addSubview(counterStackView)
        addedToCartView.addSubview(goToCartButton)
        
        counterStackView.translatesAutoresizingMaskIntoConstraints = false
        goToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            counterStackView.topAnchor.constraint(equalTo: addedToCartView.topAnchor, constant: 8),
            counterStackView.bottomAnchor.constraint(equalTo: addedToCartView.bottomAnchor, constant: -8),
            counterStackView.leadingAnchor.constraint(equalTo: addedToCartView.leadingAnchor, constant: 8),
            counterStackView.trailingAnchor.constraint(equalTo: addedToCartView.centerXAnchor, constant: -8),
            
            goToCartButton.topAnchor.constraint(equalTo: addedToCartView.topAnchor, constant: 8),
            goToCartButton.bottomAnchor.constraint(equalTo: addedToCartView.bottomAnchor, constant: -8),
            goToCartButton.trailingAnchor.constraint(equalTo: addedToCartView.trailingAnchor, constant: -8),
            goToCartButton.leadingAnchor.constraint(equalTo: addedToCartView.centerXAnchor, constant: 8),
        ])
        
        addedToCartView.isHidden = true

    }
    
    func configureImage(_ url: String) {
        let imageURL = itemViewModel.image
        SearchViewModel.shared.getPhoto(imageURL) { result in
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
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func configureTitleLabel(_ title: String) {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    func configurePriceLabel(_ price: String) {
        priceLabel.text = price
        priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        priceLabel.textColor = .systemBlue
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8),
        ])
    }
    
    
    func configureCategoryLabel(_ category: String) {
        categoryLabel.text = category
        categoryLabel.font = .systemFont(ofSize: 17)
        categoryLabel.textColor = .systemBlue
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8),
        ])
    }
    
    func configureAddButton() {
        addButton.setTitle("Добавить в корзину", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 8
        contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        ShoppingListViewModel.shared.addProduct(itemViewModel.product)
        addButton.isHidden = true
        addedToCartView.isHidden = false
        setValueForPlaceholder()
    }
    
    @objc func toCartButtonTapped() {
        if let tabBarController = self.tabBarController {
           tabBarController.selectedIndex = 1
       }
    }
    
    func configureDescriptionLabel(_ desc: String) {
        descriptionLabel.text = desc
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureShareButton() {
        shareButton.setTitle("Поделиться", for: .normal)
        shareButton.backgroundColor = .systemBlue
        shareButton.layer.cornerRadius = 8
        contentView.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            shareButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shareButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    @objc func shareButtonTapped() {
        let productName = itemViewModel.title
        let productDescription = itemViewModel.description
        let productPrice = itemViewModel.price
        let shareText = "Посмотрите этот товар: \(productName)\nОписание: \(productDescription)\nЦена: \(productPrice)"

        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
    }
}
