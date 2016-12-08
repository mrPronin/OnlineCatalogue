//
//  ManagedProduct+CoreDataProperties.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/8/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation
import CoreData


extension ManagedProduct {

    @nonobjc public class func request() -> NSFetchRequest<ManagedProduct> {
        return NSFetchRequest<ManagedProduct>(entityName: "ManagedProduct");
    }

    @NSManaged public var id: String
    @NSManaged public var site_id: String?
    @NSManaged public var title: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var currency_id: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var picture: String?
    @NSManaged public var timeStamp: NSDate?
}
