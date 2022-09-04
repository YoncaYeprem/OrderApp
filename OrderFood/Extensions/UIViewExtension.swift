//
//  UIViewExtension.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 28.08.2022.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius:CGFloat{
        get{ return cornerRadius }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
