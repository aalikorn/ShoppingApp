//
//  SearchViewController+UISearchResult.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else { return }
        self.updateResults(searchBarText: text)
        self.historyTableView.isHidden = true
        SearchViewModel.shared.saveToHistory(text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSearchHistory(searchText)
        historyTableView.reloadData()
        historyTableView.isHidden = filteredHistory.isEmpty
        updateTableViewHeight()
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.updateResults(searchBarText: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if SearchViewModel.shared.searchHistory.count != 0 {
            filterSearchHistory("")
            updateTableViewHeight()
            self.historyTableView.isHidden = false
            self.historyTableView.reloadData()
        }
        self.view.layoutIfNeeded()
    }
    
    public func updateResults(searchBarText: String?) {
        if let searchBarText = searchBarText?.lowercased(){
            SearchViewModel.shared.currentPage = 1
            guard !searchBarText.isEmpty else {
                SearchViewModel.shared.currentPage = 1
                SearchViewModel.shared.loadProducts(param: "")
                return
            }
            SearchViewModel.shared.products.removeAll()
            SearchViewModel.shared.currentPage = 1
            SearchViewModel.shared.loadProducts(param: "title=\(searchBarText)&")
        }
    }
    
    
    
}
