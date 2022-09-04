//
//  OrderModel.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 30.08.2022.
//

import Foundation

class OrderModel : Decodable {
    let id:String?
    let name:String?
    let dish: DishModel?
    
    init(id:String,name:String,dish: DishModel) {
        self.id = id
        self.name = name
        self.dish = dish
    }
    
}
