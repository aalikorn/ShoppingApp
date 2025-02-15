//
//  PriceRangeFilterCell.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

class PriceRangeFilterCell: UITableViewCell {
    let minPriceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1.2
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.textAlignment = .center
        return textField
    }()
    let maxPriceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "10000"
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1.2
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.textAlignment = .center
        return textField
    }()
    
    let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "от"
        return label
    }()
    
    let toLabel: UILabel = {
        let label = UILabel()
        label.text = "до"
        return label
    }()
    
    var stackView: UIStackView!
    
    func configureStackView() {
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
        minPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minPriceTextField.widthAnchor.constraint(equalToConstant: 100)
        ])
        maxPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxPriceTextField.widthAnchor.constraint(equalToConstant: 100)
        ])
        stackView = UIStackView(arrangedSubviews: [fromLabel, minPriceTextField, toLabel, maxPriceTextField])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


