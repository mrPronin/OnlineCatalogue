//
//  ProductsMemStore.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation

class ProductsMemStore: ProductsStoreProtocol {
    
    func fetchStoredProducts(_ completionHandler: @escaping (_ products: [Product]) -> Void)
    {
    }
}
