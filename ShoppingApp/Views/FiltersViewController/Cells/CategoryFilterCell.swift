//
//  CategoryFilterCell.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

class CategoryFilterCell: UITableViewCell {
    private let categories: [String] = ["Электроника", "Мебель", "Одежда", "Обувь", "Разное"]
    private var categoryButtons: [CategoryButton] = []
    
    private var selectedCategory: CategoryButton? {
        didSet {
            oldValue?.isSelected = false
            selectedCategory?.isSelected = true
        }
    }
    
    @objc private func categorySelected(_ sender: CategoryButton) {
        if self.selectedCategory === sender {
            self.selectedCategory = nil
            return
        }
        selectedCategory = sender
        FiltersViewModel.shared.category = sender.titleLabel?.text
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createStackView() {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        let row1 = createRowStackView()
        let row2 = createRowStackView()
        
        mainStackView.addArrangedSubview(row1)
        mainStackView.addArrangedSubview(row2)
        
        for (index, category) in categories.enumerated() {
            let button = CategoryButton()
            button.setTitle(category, for: .normal)
            button.addTarget(self, action: #selector(categorySelected(_:)), for: .touchUpInside)
            
            if index < 2 {
                row1.addArrangedSubview(button)
            } else {
                row2.addArrangedSubview(button)
            }
            
            categoryButtons.append(button)
        }
        
    }
    
    private func createRowStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }
    
    
}

class CategoryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
        setTitleColor(.systemBlue, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = .white
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemBlue : .white
            setTitleColor(isSelected ? .white : .systemBlue, for: .normal)
        }
    }
}
