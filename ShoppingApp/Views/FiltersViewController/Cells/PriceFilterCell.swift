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
        textField.textAlignment = .center
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
        
        configureDoneButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDoneButton() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
       toolbar.sizeToFit()

       
       let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       
       toolbar.setItems([flexibleSpace, doneButton], animated: false)
       priceTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        priceTextField.resignFirstResponder()
    
        if let text = priceTextField.text, let price = Double(text) {
            FiltersViewModel.shared.price = price
        }
    }
}

