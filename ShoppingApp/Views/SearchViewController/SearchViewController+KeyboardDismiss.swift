//
//  SearchViewController+KeyboardDismiss.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

extension SearchViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.resignFirstResponder()
        historyTableView.isHidden = true
    }
    
    func setupKeyboardDismissRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func dismissKeyboard() {
        searchController.resignFirstResponder()
    }
}
