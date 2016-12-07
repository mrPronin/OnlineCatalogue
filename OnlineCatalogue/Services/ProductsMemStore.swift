//
//  ProductsMemStore.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation

class ProductsMemStore: ProductsStoreProtocol {
    
    // MARK: - Data
    
    var products = [
        Product(
            id: "MLU441497969",
            site_id: "MLU",
            title: "Notebook Acer 14 Cloudbook 32gb Win10 Hasta 12 Pagos S/rec",
            price: NSDecimalNumber(string: "199.99"),
            currency_id: "USD",
            thumbnail: "http://mlu-s2-p.mlstatic.com/585221-MLU20740156773_052016-I.jpg",
            picture: "http://mlu-s2-p.mlstatic.com/585221-MLU20740156773_052016-O.jpg"
        ),
        Product(
            id: "MLU440035730",
            site_id: "MLU",
            title: "Notebook Hp Quad Core Tactil A8 1tb 8gb 12 Pagos S/ Rec Loi",
            price: NSDecimalNumber(string: "467"),
            currency_id: "USD",
            thumbnail: "http://mlu-s1-p.mlstatic.com/555215-MLU25154537916_112016-I.jpg",
            picture: "http://mlu-s1-p.mlstatic.com/555215-MLU25154537916_112016-O.jpg"
        ),
        Product(
            id: "MLU441022981",
            site_id: "MLU",
            title: "Notebook Lenovo Core I3 2.20 8gb 15.6'' Wifi Bluetooth Nnet",
            price: NSDecimalNumber(string: "465"),
            currency_id: "USD",
            thumbnail: "http://mlu-s1-p.mlstatic.com/244015-MLU25201181665_122016-I.jpg",
            picture: "http://mlu-s1-p.mlstatic.com/244015-MLU25201181665_122016-O.jpg"
        ),
        Product(
            id: "MLU440870221",
            site_id: "MLU",
            title: "Notebook Acer Core I3 15.6' 1tb Bt Win10 12 Pagos S/rec Loi",
            price: NSDecimalNumber(string: "417"),
            currency_id: "USD",
            thumbnail: "http://mlu-s1-p.mlstatic.com/325115-MLU25158868438_112016-I.jpg",
            picture: "http://mlu-s1-p.mlstatic.com/325115-MLU25158868438_112016-O.jpg"
        ),
        Product(
            id: "MLU441083814",
            site_id: "MLU",
            title: "Notebook Hp Quad Core Win10 Mouse Y Estuche 12 Pagos S/ Rec",
            price: NSDecimalNumber(string: "399"),
            currency_id: "USD",
            thumbnail: "http://mlu-s2-p.mlstatic.com/588505-MLU25047318880_092016-I.jpg",
            picture: "http://mlu-s2-p.mlstatic.com/588505-MLU25047318880_092016-O.jpg"
        )
    ]
    
    func fetchStoredProducts(_ completionHandler: @escaping (_ products: [Product]) -> Void)
    {
        completionHandler(products)
    }
    
    func searchProducts(_ completionHandler: @escaping (_ products: [Product]) -> Void)
    {
        completionHandler(products)
    }
}
