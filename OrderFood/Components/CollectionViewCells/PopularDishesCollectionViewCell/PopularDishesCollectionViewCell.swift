//
//  PopularDishesCollectionViewCell.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import UIKit
import Kingfisher

class PopularDishesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: PopularDishesCollectionViewCell.self)
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishCaloriesLabel: UILabel!
    @IBOutlet weak var dishDescriptionLbl: UILabel!
    
    func setup(dish:DishModel){
        titleLbl.text = dish.name
        dishImage.kf.setImage(with: dish.image?.asUrl)
        dishCaloriesLabel.text = dish.formattedCalories
        dishDescriptionLbl.text = dish.description
    }
}
