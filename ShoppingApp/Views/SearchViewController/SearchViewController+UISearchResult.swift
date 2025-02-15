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
            SearchViewModel.shared.currentPage = 1
            guard !searchBarText.isEmpty else {
                SearchViewModel.shared.loadProducts()
                return
            }
            SearchViewModel.shared.products.removeAll()
            SearchViewModel.shared.loadProducts(title: searchBarText)
        }
    }
    
}
