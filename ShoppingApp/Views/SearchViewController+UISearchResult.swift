//
//  SearchViewController+UISearchResult.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.updateResults(searchBarText: searchController.searchBar.text)
    }
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
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
