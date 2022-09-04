//
//  DishCategoryTableViewCell.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 30.08.2022.
//

import UIKit
import Kingfisher

class DishCategoryTableViewCell: UITableViewCell {
    
    static let identifier:String = String(describing: DishCategoryTableViewCell.self)

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLbl: UILabel!
    @IBOutlet weak var dishDescriptionLbl: UILabel!
    
    func setup(dish:DishModel){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishTitleLbl.text = dish.name
        dishDescriptionLbl.text = dish.description
    }
    
    func setup(order:OrderModel){
        
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        dishTitleLbl.text = order.dish?.name
        dishDescriptionLbl.text = order.name
    }
    
}
