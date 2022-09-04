//
//  StringExtension.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 29.08.2022.
//

import Foundation

extension String {
    var asUrl:URL?{
        return URL(string: self)
    }
}
