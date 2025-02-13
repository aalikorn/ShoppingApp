//
//  ShoppingListViewController+UITableView.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import UIKit

extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return shoppingListViewModel.shoppingList.count
    }
    
    
}
