//
//  SearchBarWithFilter.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

class SearchBarWithFilter: UISearchBar {
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let searchField = self.value(forKey: "searchField") as? UITextField else { return }
        
        filterButton.frame = CGRect(x: searchField.frame.width - 35, y: 0, width: 30, height: searchField.frame.height)
        filterButton.addTarget(self, action: #selector(openFilter), for: .touchUpInside)
        
        searchField.rightView = filterButton
        searchField.rightViewMode = .always
    }

    @objc private func openFilter() {
        print("Фильтр нажат!")
    }
}
