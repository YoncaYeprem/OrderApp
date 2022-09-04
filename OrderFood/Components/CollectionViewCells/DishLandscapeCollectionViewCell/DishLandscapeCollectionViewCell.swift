//
//  DishLandscapeCollectionViewCell.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import UIKit
import Kingfisher

class DishLandscapeCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: DishLandscapeCollectionViewCell.self)
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var dishDescriptionLbl: UILabel!
    @IBOutlet weak var dishCaloriesLbl: UILabel!
    
    func setup(dish:DishModel){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishNameLbl.text = dish.name
        dishDescriptionLbl.text = dish.description
        dishCaloriesLbl.text = dish.formattedCalories
        
    }
}
