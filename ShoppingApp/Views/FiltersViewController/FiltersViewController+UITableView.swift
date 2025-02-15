//
//  FiltersViewController+UITableView.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 11.02.2025.
//

import UIKit

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filters = FiltersViewModel.shared
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleFilterCell", for: indexPath) as! TitleFilterCell
            if let title = filters.name {
                cell.titleTextField.attributedPlaceholder = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            } else {
                cell.titleTextField.placeholder = "Введите название"
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceFilterCell", for: indexPath) as! PriceFilterCell
            if let price = filters.price {
                cell.priceTextField.attributedPlaceholder = NSAttributedString(string: String(price), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            } else {
                cell.priceTextField.placeholder = "1000"
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceRangeFilterCell", for: indexPath) as! PriceRangeFilterCell
            if let minPrice = filters.minPrice {
                cell.minPriceTextField.attributedPlaceholder = NSAttributedString(string: String(minPrice), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            } else {
                cell.minPriceTextField.placeholder = "0"
            }
            if let maxPrice = filters.maxPrice {
                cell.maxPriceTextField.attributedPlaceholder = NSAttributedString(string: String(maxPrice), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            } else {
                cell.maxPriceTextField.placeholder = "1000"
            }
            return cell
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: "CategoryFilterCell", for: indexPath)
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ApplyCell", for: indexPath) as! ApplyCell
            cell.closeControllerHandler = { [weak self] in
                self?.closeController()
            }
            return cell
        default:
            break
        }
        return tableView.dequeueReusableCell(withIdentifier: "TitleFilterCell", for: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Название продукта"
        case 1: return "Точная цена"
        case 2: return "Ценовой диапазон"
        case 3: return "Категория продуктов"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .black
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 60
        case 1: return 60
        case 2: return 60
        case 3: return 90
        case 4: return 90
        default: return 0
        }
    }

}
