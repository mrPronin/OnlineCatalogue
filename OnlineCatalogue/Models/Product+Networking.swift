//
//  Product+Networking.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/8/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation
import Alamofire

extension Product {
    convenience init?(json: [String: Any]) {
        
        guard let productID = json["id"] as? String else {
            return nil
        }
        let site_id = json["site_id"] as? String
        let title = json["title"] as? String
        
        var price: NSDecimalNumber?
        if let priceDouble = json["price"] as? Double {
            let priceString = String(priceDouble)
            price = NSDecimalNumber(string: priceString)
        }
        
        let currency_id = json["currency_id"] as? String
        let thumbnail = json["thumbnail"] as? String
        let picture = json["picture"] as? String
        self.init(id: productID, site_id: site_id, title: title, price: price, currency_id: currency_id, thumbnail: thumbnail, picture: picture)
    }
}
