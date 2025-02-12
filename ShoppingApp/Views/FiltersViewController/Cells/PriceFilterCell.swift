//
//  PriceFilterCell.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

class PriceFilterCell: UITableViewCell {
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "1000"
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1.2
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(priceTextField)
        
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceTextField.widthAnchor.constraint(equalToConstant: 100),
            priceTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            priceTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

