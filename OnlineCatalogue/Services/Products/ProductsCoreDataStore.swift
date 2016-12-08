//
//  ProductsCoreDataStore.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProductsCoreDataStore: ProductsStoreProtocol {
    
    func fetchStoredProducts(_ completionHandler: @escaping (_ products: [Product], _ error: ProductsOperationError?) -> Void)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            let productsOperationError = ProductsOperationError.cannotCreate("Could not AppDelegate!")
            completionHandler([], productsOperationError)
            return
        }
        let managedContext = appDelegate.coreDataManager.persistentContainer.viewContext
        let fetchRequest = ManagedProduct.request()
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 5
        do {
            let managedProducts = try managedContext.fetch(fetchRequest)
            var storedProducts: [Product] = []
            for managedProduct in managedProducts {
                let product = Product(managedObject: managedProduct)
                storedProducts.append(product!)
            }
            completionHandler(storedProducts, nil)
        } catch let error as NSError {
            let productsOperationError = ProductsOperationError.cannotFetch("Could not fetch. \(error), \(error.userInfo)")
            completionHandler([], productsOperationError)
        }
    }
    
    func searchProducts(_ searchString: String,  completionHandler: @escaping (_ products: [Product]) -> Void)
    {
        completionHandler([])
    }
    
    func fetchProduct(_ id: String, completionHandler: @escaping (_ product: Product?, _ error: ProductsOperationError?) -> Void)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            let productsOperationError = ProductsOperationError.cannotCreate("Could not AppDelegate!")
            completionHandler(nil, productsOperationError)
            return
        }
        let managedContext = appDelegate.coreDataManager.persistentContainer.viewContext
        let fetchRequest = ManagedProduct.request()
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        do {
            let managedProducts = try managedContext.fetch(fetchRequest)
            if managedProducts.count > 0 {
                let product = Product(managedObject: managedProducts[0])
                completionHandler(product, nil)
            } else {
                let productsOperationError = ProductsOperationError.cannotFetch("Could not fetch!")
                completionHandler(nil, productsOperationError)
            }
        } catch let error as NSError {
            let productsOperationError = ProductsOperationError.cannotFetch("Could not fetch. \(error), \(error.userInfo)")
            completionHandler(nil, productsOperationError)
        }
    }
    
    func storeProduct(_ productToStore: Product, completionHandler: @escaping (_ error: ProductsOperationError?) -> Void)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            let productsOperationError = ProductsOperationError.cannotCreate("Could not AppDelegate!")
            completionHandler(productsOperationError)
            return
        }
        let managedContext = appDelegate.coreDataManager.persistentContainer.viewContext
        
        // Check if product already exists
        let fetchRequest = ManagedProduct.request()
        let predicate = NSPredicate(format: "id == %@", productToStore.id)
        fetchRequest.predicate = predicate
        var managedProductsCount = 0
        do {
            managedProductsCount = try managedContext.count(for: fetchRequest)
        } catch let error as NSError {
            let productsOperationError = ProductsOperationError.cannotFetch("Could not fetch. \(error), \(error.userInfo)")
            completionHandler(productsOperationError)
        }
        if managedProductsCount == 0 {
            let entity = ManagedProduct.entity()
            let managedProduct = ManagedProduct(entity: entity, insertInto: managedContext)
            managedProduct.timeStamp = NSDate()
            managedProduct.id = productToStore.id
            managedProduct.site_id = productToStore.site_id
            managedProduct.title = productToStore.title
            managedProduct.price = productToStore.price
            managedProduct.currency_id = productToStore.currency_id
            managedProduct.thumbnail = productToStore.thumbnail
            managedProduct.picture = productToStore.picture
            
            do {
                try managedContext.save()
                completionHandler(nil)
            } catch let error as NSError {
                let productsOperationError = ProductsOperationError.cannotCreate(error.description)
                completionHandler(productsOperationError)
            }
        } else {
            completionHandler(nil)
        }
    }
}
