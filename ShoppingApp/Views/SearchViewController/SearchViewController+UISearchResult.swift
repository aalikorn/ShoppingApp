//
//  SearchViewController+UISearchResult.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateResults(searchBarText: searchText)
    }
    
    public func updateResults(searchBarText: String?) {
        if let searchBarText = searchBarText?.lowercased(){
            self.searchViewModel.currentPage = 1
            guard !searchBarText.isEmpty else {
                self.searchViewModel.loadProducts()
                return
            }
            self.searchViewModel.products.removeAll()
            self.searchViewModel.loadProducts(title: searchBarText)
        }
    }
    
}
