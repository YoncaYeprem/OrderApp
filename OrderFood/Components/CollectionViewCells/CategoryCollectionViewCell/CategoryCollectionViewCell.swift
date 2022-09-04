//
//  CategoryCollectionViewCell.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CategoryCollectionViewCell.self)

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    func setup(category:DishCategoryModel) {
        categoryTitleLabel.text = category.title
        categoryImageView.kf.setImage(with: category.image?.asUrl)
       
    }
}
