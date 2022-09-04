//
//  DishCategoryModel.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import Foundation
import UIKit

class DishCategoryModel : Decodable {
    let id:String?
    let title:String?
    let image:String?
    
    init(id:String,title:String,image:String ) {
        self.id = id
        self.title = title
        self.image = image
    }
}
