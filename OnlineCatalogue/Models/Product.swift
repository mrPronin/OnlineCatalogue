//
//  Product.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation

struct Product: Equatable
{
    var id: String?
    var site_id: String?
    var title: String?
    var price: NSDecimalNumber?
    var currency_id: String?
    var thumbnail: String?
    var picture: String?
}

func ==(lhs: Product, rhs: Product) -> Bool
{
    return lhs.id == rhs.id
        && lhs.site_id == rhs.site_id
        && lhs.title == rhs.title
        && lhs.currency_id == rhs.currency_id
}
