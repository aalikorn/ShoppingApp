//
//  SearchViewController+SearchHistory.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 16.02.2025.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupHistoryTableView() {
        view.addSubview(historyTableView)
        historyTableView.isHidden = true
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "historyCell")
        historyTableView.layer.borderColor = UIColor.gray.cgColor
        historyTableView.layer.borderWidth = 0.4
        historyTableView.layer.cornerRadius = 10
        
        self.historyHeightAnchor = self.historyTableView.heightAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([
           
            historyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = filteredHistory[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = filteredHistory[indexPath.row]
        searchController.text = query
        SearchViewModel.shared.loadProducts(title: query)
        historyTableView.isHidden = true
        searchController.endEditing(true)
    }
    
    func updateTableViewHeight() {
        historyHeightAnchor.isActive = false
        let numberOfRows = filteredHistory.count
        let rowHeight: CGFloat = 48
        let totalHeight = CGFloat(numberOfRows) * rowHeight
        historyHeightAnchor = self.historyTableView.heightAnchor.constraint(equalToConstant: totalHeight)
        historyHeightAnchor.isActive = true
    }
    
    func addBottomBorder(to view: UIView, height: CGFloat, color: UIColor) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalToConstant: height),
            border.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func filterSearchHistory(_ query: String) {
        let history = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []
        if query.isEmpty {
            filteredHistory = history
            historyTableView.reloadData()
            historyTableView.isHidden = false
        } else {
            filteredHistory = history.filter { $0.range(of: query, options: .caseInsensitive) != nil }
            historyTableView.reloadData()
            historyTableView.isHidden = false
        }
    }
}
