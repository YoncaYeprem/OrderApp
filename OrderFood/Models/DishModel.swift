//
//  DishModel.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import Foundation

class DishModel : Decodable{
    let id, name, description, image: String?
    let calories: Int?
    
    var formattedCalories : String {
        //return String(format: "%.2f calories", calories ?? 0)
        return "\(calories ?? 0) calories"
    }
    
    
    init(id:String, name:String, description:String, image:String, calories:Int) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.calories = calories
    }

}
