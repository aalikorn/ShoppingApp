//
//  ShoppingListItemCell.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import UIKit

class ShoppingListItemCell: UITableViewCell {
    var itemImageView: UIImageView!
    var titleLabel: UILabel!
    var priceLabel: UILabel!
    var quantityStackView: UIStackView!
    var quantityTextField: UITextField!
    var plusButton: UIButton!
    var minusButton: UIButton!
    var removeButton: UIButton!
    var item: ShoppingListItem!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(item: ShoppingListItem, image: UIImage?, title: String, price: Double, quantity: Int) {
        self.item = item
        let image = image ?? UIImage(named: "placeholder")!
        confgureImage(image)
        conigureTitle(title)
        configurePrice(price)
        configureQuantityStackView(quantity)
        configureRemoveButton()
    }
    
    func confgureImage(_ image: UIImage) {
        itemImageView = UIImageView(image: image)
        itemImageView.contentMode = .scaleAspectFit
        contentView.addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 100),
            itemImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func conigureTitle(_ title: String) {
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8)
        ])
    }
    
    func configurePrice(_ price: Double) {
        priceLabel = UILabel()
        priceLabel.text = "$\(price)"
        priceLabel.font = .systemFont(ofSize: 17, weight: .bold)
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8)
        ])
    }
    
    func configureQuantityStackView(_ quantity: Int) {
        minusButton = UIButton(type: .system)
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .medium)
        minusButton.setTitleColor(.systemBlue, for: .normal)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        plusButton = UIButton(type: .system)
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .medium)
        plusButton.setTitleColor(.systemBlue, for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        quantityTextField = UITextField()
        quantityTextField.attributedPlaceholder = NSAttributedString(
            string: String(quantity),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        quantityTextField.layer.borderWidth = 1
        quantityTextField.layer.borderColor = UIColor.systemBlue.cgColor
        quantityTextField.layer.cornerRadius = 8
        quantityTextField.textAlignment = .center
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quantityTextField.widthAnchor.constraint(equalToConstant: 30),
            quantityTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        
        quantityTextField.keyboardType = .numberPad
        quantityStackView = UIStackView(arrangedSubviews: [minusButton, quantityTextField, plusButton])
        quantityStackView.axis = .horizontal
        quantityStackView.spacing = 2
        quantityStackView.alignment = .center
        quantityStackView.distribution = .equalCentering
        contentView.addSubview(quantityStackView)
        quantityStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityStackView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            quantityStackView.heightAnchor.constraint(equalToConstant: 70),
            quantityStackView.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: -4)
        ])
        
    }
    
    func configureRemoveButton() {
        removeButton = UIButton(type: .system)
        removeButton.setTitle("Удалить", for: .normal)
        removeButton.backgroundColor = .systemRed
        removeButton.layer.cornerRadius = 8
        removeButton.setTitleColor(.white, for: .normal)
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        contentView.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeButton.leadingAnchor.constraint(equalTo: quantityStackView.trailingAnchor, constant: 20),
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            removeButton.widthAnchor.constraint(equalToConstant: 100),
            removeButton.centerYAnchor.constraint(equalTo: quantityStackView.centerYAnchor)
        ])
    }
    
    @objc func minusButtonTapped() {
        ShoppingListViewModel.shared.updateQuantity(for: item.product, newQuantity: item.quantity - 1)
    }
    
    @objc func plusButtonTapped() {
        ShoppingListViewModel.shared.updateQuantity(for: item.product, newQuantity: item.quantity + 1)
    }
    
    @objc func removeButtonTapped() {
        ShoppingListViewModel.shared.removeProduct(item.product)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
}
