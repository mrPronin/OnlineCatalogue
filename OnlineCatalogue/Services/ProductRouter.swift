//
//  ProductRouter.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/8/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation
import Alamofire

enum ProductRouter: URLRequestConvertible {
    case search(query: String)
    case get(id: String)
    
    static let baseURLString = "https://api.mercadolibre.com"
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let parameters: ([String: Any]?) = {
            switch self {
            case .get:
                return nil
            case .search(let query):
                return ["q": query]
            }
        }()
        let path: String = {
            switch self {
            case .search:
                return "/sites/MLU/search"
            case .get(let id):
                return "/items/\(id)"
            }
        }()
        let url = try ProductRouter.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
