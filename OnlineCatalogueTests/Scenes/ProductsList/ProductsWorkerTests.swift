//
//  ProductsListWorkerTests.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright (c) 2016 Aleksandr Pronin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

@testable import OnlineCatalogue
import XCTest

class ProductsWorkerTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: ProductsWorker!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupProductsWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupProductsWorker()
    {
        sut = ProductsWorker(productsStore: ProductsMemStoreSpy())
    }
    
    // MARK: - Test doubles
    
    class ProductsMemStoreSpy: ProductsMemStore
    {
        // MARK: Method call expectation
        var fetchStoredProductsCalled = false
        
        func fetchStoredProducts(_ completionHandler: @escaping (_ products: [Product]) -> Void)
        {
            fetchStoredProductsCalled = true
            let oneSecond = DispatchTime.now() + Double(1 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: oneSecond, execute: {
                let products = [
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
                    )
                ]
                completionHandler(products as! [Product])
            })
        }
    }
    
    // MARK: - Tests
    
    func testFetchOrdersShouldReturnListOfOrders()
    {
        // Given
        let productsMemStoreSpy = sut.productsStore as! ProductsMemStoreSpy
        
        // When
        let expectation = self.expectation(description: "Wait for fetchStoredProducts() to return")
        sut.fetchStoredProducts { (products: [Product], nil) -> Void in
            expectation.fulfill()
        }
        
        // Then
        XCTAssert(productsMemStoreSpy.fetchStoredProductsCalled, "Calling fetchStoredProducts() should ask the data store for a list of products")
        waitForExpectations(timeout: 1.1) { _ in
            XCTAssert(true, "Calling fetchStoredProducts() should result in the completion handler being called with the fetched products result")
        }
    }
}
