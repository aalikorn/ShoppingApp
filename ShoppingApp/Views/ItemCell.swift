//
//  ItemCell.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    
    func configure(title: String, image: UIImage?) {
        titleLabel.text = title
        imageView.image = image ?? UIImage(named: "placeholder")
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       
       imageView = UIImageView()
       titleLabel = UILabel()
    
       
       contentView.addSubview(imageView)
       contentView.addSubview(titleLabel)
       
       setupConstraints()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.clipsToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
       imageView.translatesAutoresizingMaskIntoConstraints = false
       titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
       
       
       NSLayoutConstraint.activate([
           imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
           imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
           imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
           imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
       ])
       
       
   }
}
