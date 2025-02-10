//
//  SearchViewController+UICollectionView.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import UIKit

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemCell.self)", for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        let product = searchViewModel.products[indexPath.item]
        if let imageURL = product.images.first {
            searchViewModel.getPhoto(imageURL) { result in
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
    
    
}
