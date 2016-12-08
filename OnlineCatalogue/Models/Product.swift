//
//  Product.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation

class Product: Equatable
{
    var id: String
    var site_id: String?
    var title: String?
    var price: NSDecimalNumber?
    var currency_id: String?
    var thumbnail: String?
    var picture: String?
    
    required init?(id: String, site_id: String?, title: String?, price: NSDecimalNumber?, currency_id: String?, thumbnail: String?, picture: String?) {
        self.id = id
        self.site_id = site_id
        self.title = title
        self.price = price
        self.currency_id = currency_id
        self.thumbnail = thumbnail
        self.picture = picture
    }
    
    func description() -> String {
        var descriptionString = "id: [\(self.id)]"
        if let site_id = self.site_id {
            descriptionString += " site_id: [\(site_id)]"
        }
        if let title = self.title {
            descriptionString += " title: [\(title)]"
        }
        if let price = self.price {
            descriptionString += " price: [\(price)]"
        }
        if let currency_id = self.currency_id {
            descriptionString += " currency_id: [\(currency_id)]"
        }
        if let thumbnail = self.thumbnail {
            descriptionString += "\n thumbnail: [\(thumbnail)]"
        }
        if let picture = self.picture {
            descriptionString += "\n picture: [\(picture)]"
        }
        return descriptionString
    }
}

func ==(lhs: Product, rhs: Product) -> Bool
{
    return lhs.id == rhs.id
        && lhs.site_id == rhs.site_id
        && lhs.title == rhs.title
        && lhs.currency_id == rhs.currency_id
}
