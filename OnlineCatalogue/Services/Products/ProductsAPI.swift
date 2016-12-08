//
//  ProductsAPI.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation
import Alamofire

class ProductsAPI: ProductsStoreProtocol {
    
    func fetchStoredProducts(_ completionHandler: @escaping (_ products: [Product], _ error: ProductsOperationError?) -> Void)
    {
        completionHandler([], nil)
    }
    
    func searchProducts(_ searchString: String,  completionHandler: @escaping (_ products: [Product]) -> Void)
    {
        Alamofire.request(ProductRouter.search(query: searchString)).responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print(response.result.error!)
                completionHandler([])
                return
            }
            
            // make sure we got JSON and it's a dictionary
            guard let json = response.result.value as? [String: Any] else {
                print("Didn't get todo object as JSON from API")
                completionHandler([])
                return
            }
            
            if let jsonProducts = json["results"] as? [[String : Any]] {
                var products:[Product] = []
                for jsonProduct in jsonProducts {
                    // turn JSON in to Product object
                    guard let product = Product(json: jsonProduct) else {
                        print("Could not create Product object from JSON")
                        continue
                    }
                    products.append(product)
                }
                completionHandler(products)
            }
        }
    }
    
    func fetchProduct(_ id: String, completionHandler: @escaping (_ product: Product?, _ error: ProductsOperationError?) -> Void)
    {
        Alamofire.request(ProductRouter.get(id: id)).responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                let productsOperationError = ProductsOperationError.cannotFetch((response.result.error?.localizedDescription)!)
                completionHandler(nil, productsOperationError)
                return
            }
            
            // make sure we got JSON and it's a dictionary
            guard let jsonProduct = response.result.value as? [String: Any] else {
                let productsOperationError = ProductsOperationError.cannotFetch("Didn't get todo object as JSON from API")
                completionHandler(nil, productsOperationError)
                return
            }
            
            // turn JSON in to Product object
            guard let product = Product(json: jsonProduct) else {
                let productsOperationError = ProductsOperationError.cannotFetch("Could not create Product object from JSON")
                completionHandler(nil, productsOperationError)
                return
            }
            
            // try to get picture url
            if let jsonPictures = jsonProduct["pictures"] as? [[String : Any]] {
                if jsonPictures.count > 0 {
                    let jsonPicture = jsonPictures[0] as [String : Any]
                    let pictureURLString = jsonPicture["url"] as? String
                    product.picture = pictureURLString
                }
            }
            completionHandler(product, nil)
        }
    }
    
    
    func storeProduct(_ productToStore: Product, completionHandler: @escaping (_ error: ProductsOperationError?) -> Void)
    {
        completionHandler(nil)
    }
}
