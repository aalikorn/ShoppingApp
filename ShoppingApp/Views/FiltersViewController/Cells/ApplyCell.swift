//
//  ApplyCell.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

class ApplyCell: UITableViewCell {
    var closeControllerHandler: (() -> Void)?
    
    let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Применить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let denyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сбросить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(applyButton)
        contentView.addSubview(denyButton)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        denyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            applyButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8),
            applyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            applyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            denyButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 8),
            denyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            denyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            denyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func applyButtonTapped() {
        SearchViewModel.shared.currentPage = 1
        SearchViewModel.shared.loadProducts(param: FiltersViewModel.shared.filtersToURLParam())
        closeControllerHandler?()
    }
    
    @objc func denyButtonTapped() {
        SearchViewModel.shared.currentPage = 1
        SearchViewModel.shared.loadProducts(param: "")
        FiltersViewModel.shared.category = nil
        FiltersViewModel.shared.minPrice = nil
        FiltersViewModel.shared.maxPrice = nil
        FiltersViewModel.shared.price = nil
        FiltersViewModel.shared.name = nil
        print("pressed")
        closeControllerHandler?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        applyButton.removeTarget(nil, action: nil, for: .allEvents)
        denyButton.removeTarget(nil, action: nil, for: .allEvents)

        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(denyButtonTapped), for: .touchUpInside)
    }

}
