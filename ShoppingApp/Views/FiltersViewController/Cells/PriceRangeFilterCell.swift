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
    
    func configureDoneButton() {
       let minToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
       minToolbar.sizeToFit()
        
        let maxToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        maxToolbar.sizeToFit()
       
       let minDoneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(minDoneButtonTapped))
        let maxDoneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(maxDoneButtonTapped))
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       
       minToolbar.setItems([flexibleSpace, minDoneButton], animated: false)
        maxToolbar.setItems([flexibleSpace, maxDoneButton], animated: false)
        minPriceTextField.inputAccessoryView = minToolbar
        maxPriceTextField.inputAccessoryView = maxToolbar
    }
    
    @objc func minDoneButtonTapped() {
        minPriceTextField.resignFirstResponder()
    
        if let text = minPriceTextField.text, let price = Double(text) {
            FiltersViewModel.shared.minPrice = price
        }
    }
    
    @objc func maxDoneButtonTapped() {
        maxPriceTextField.resignFirstResponder()
    
        if let text = maxPriceTextField.text, let price = Double(text) {
            FiltersViewModel.shared.maxPrice = price
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStackView()
        configureDoneButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


