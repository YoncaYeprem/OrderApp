//
//  AppError.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 3.09.2022.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response couldnt be decoded"
        case .unknownError:
            return "I have no ideaa"
        case .invalidUrl:
            return "It is not valid URL"
        case .serverError(let error):
            return error
        }    }
}
