//
//  NetworkService.swift
//  OrderFood
//
//  Created by YONCA YEPREM on 30.08.2022.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    
    func fetchAllCategories(completion: @escaping(Result<AllModels,Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    func placeOrder(dishId:String, name: String, completion: @escaping(Result<OrderModel,Error>) -> Void) {
        let params = ["name":name]
        request(route: .placeOrder(dishId), method: .post,paramaters: params, completion: completion)
    }
    
    func fetchCategoryDishes(categoryId:String, completion: @escaping(Result<[DishModel],Error>) -> Void) {
        request(route: .getCategoryDishes(categoryId), method: .get , completion: completion)
    }
    
    func fetchOrders(completion: @escaping(Result<[OrderModel],Error>) -> Void) {
        request(route: .fetchOrders, method: .get , completion: completion)
    }
    
    private func request<T: Decodable>(route:Route,
                                     method:Method,
                                     paramaters: [String:Any]? = nil ,
                                     completion: @escaping(Result<T,Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: paramaters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data:data, encoding: .utf8) ?? "Couldnt stringify our response"
            }else if let error = error {
                result = .failure(error)
                print("The error \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result:Result<Data, Error>?, completion: (Result<T,Error>) -> Void){
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        switch result {
            
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            }else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
     private func createRequest(
        route: Route,
        method:Method,
        parameters:[String:Any]? = nil) -> URLRequest?{
            let urlString = Route.baseUrl + route.description
            guard let url = urlString.asUrl else { return nil }
            var urlRequest = URLRequest(url:url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = method.rawValue
            
            if let params = parameters {
                switch method {
                case .get:
                    var urlComponent = URLComponents(string: urlString)
                    urlComponent?.queryItems = params.map{
                        URLQueryItem(name: $0, value: "\($1)")
                    }
                    urlRequest.url = urlComponent?.url
                case .post, .delete, .patch:
                    let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                    urlRequest.httpBody = bodyData
                }
            }
            return urlRequest
        }
}
