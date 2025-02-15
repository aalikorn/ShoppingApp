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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(applyButton)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            applyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            applyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            applyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func applyButtonTapped() {
        SearchViewModel.shared.loadProducts(param: FiltersViewModel.shared.filtersToURLParam())
        closeControllerHandler?()
    }
}
