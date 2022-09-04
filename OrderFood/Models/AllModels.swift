//
//  AllModels.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 3.09.2022.
//

import Foundation

struct AllModels : Decodable {
    let categories:[DishCategoryModel]?
    let populars: [DishModel]?
    let specials: [DishModel]?
}
