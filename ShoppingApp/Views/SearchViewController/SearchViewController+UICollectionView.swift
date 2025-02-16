//
//  SearchViewController+UICollectionView.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import UIKit

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchViewModel.shared.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemCell.self)", for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        let product = SearchViewModel.shared.products[indexPath.item]
        if let imageURL = product.images.first {
            SearchViewModel.shared.getPhoto(imageURL) { result in
                switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            cell.configure(title: product.title, image: image)
                        }
                    case .failure(let error):
                        print("Ошибка загрузки фото: \(error)")
                        DispatchQueue.main.async {
                            cell.configure(title: product.title, image: UIImage(named: "placeholder"))
                        }
                    }
            }
        }
        return cell
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 170, height: 200)
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        return layout
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > contentHeight - frameHeight * 1.5 {
            if SearchViewModel.shared.isReachedEndOfData {
                return
            }
            SearchViewModel.shared.loadProducts() {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemVC = ItemViewController()
        itemVC.itemViewModel = ItemViewModel(product: SearchViewModel.shared.products[indexPath.row])
        navigationController?.pushViewController(itemVC, animated: true)
    }
    
    
}
