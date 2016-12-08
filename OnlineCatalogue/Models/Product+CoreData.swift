//
//  Product+CoreData.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/8/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//


import Foundation
import CoreData

extension Product {
    convenience init?(managedObject: ManagedProduct) {
        self.init(id: managedObject.id, site_id: managedObject.site_id, title: managedObject.title, price: managedObject.price, currency_id: managedObject.currency_id, thumbnail: managedObject.thumbnail, picture: managedObject.picture)
    }
}
