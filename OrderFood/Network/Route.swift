//
//  Route.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 30.08.2022.
//

import Foundation

enum Route {
    static let baseUrl = "https://yummie.glitch.me"
    
    case fetchAllCategories
    case placeOrder(String)
    case getCategoryDishes(String)
    case fetchOrders
    
    var description : String {
        switch self {
        case .fetchAllCategories: return "/dish-categories"
        case .placeOrder(let dishId): return "/orders/\(dishId)"
        case .getCategoryDishes(let categoryId): return "/dishes/\(categoryId)"
        case .fetchOrders: return "/orders"

        }
    }
}
