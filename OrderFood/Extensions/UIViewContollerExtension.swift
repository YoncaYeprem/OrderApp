//
//  UIViewContollerExtension.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier : String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
         
    }
}
