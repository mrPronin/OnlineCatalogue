//
//  ProductsListPresenterTests.swift
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

class ProductsListPresenterTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: ProductsListPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupProductsListPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupProductsListPresenter()
    {
        sut = ProductsListPresenter()
    }
    
    // MARK: - Test doubles
    
    class ProductsListPresenterOutputSpy: ProductsListPresenterOutput
    {
        // MARK: Method call expectations
        var displayFetchedStoredOrdersCalled = false
        var displaySearchResultCalled = false
        
        // MARK: Argument expectations
        var viewModel: ProductsList.FetchStoredProducts.ViewModel!
        
        // MARK: Spied methods
        func displayFetchedStoredOrders(viewModel: ProductsList.FetchStoredProducts.ViewModel)
        {
            displayFetchedStoredOrdersCalled = true
            self.viewModel = viewModel
        }
        
        func displaySearchResult(viewModel: ProductsList.SearchProducts.ViewModel)
        {
            displaySearchResultCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testPresentFetchedStoredProductsShouldFormatFetchedStoredProductsForDisplay()
    {
        // Given
        let productsListPresenterOutputSpy = ProductsListPresenterOutputSpy()
        sut.output = productsListPresenterOutputSpy
        
        let products = [
            Product(
                id: "MLU441497969",
                site_id: "MLU",
                title: "Notebook Acer 14 Cloudbook 32gb Win10 Hasta 12 Pagos S/rec",
                price: NSDecimalNumber(string: "199"),
                currency_id: "USD",
                thumbnail: "http://mlu-s2-p.mlstatic.com/585221-MLU20740156773_052016-I.jpg",
                picture: "http://mlu-s2-p.mlstatic.com/585221-MLU20740156773_052016-O.jpg"
            )
        ]
        let response = ProductsList.FetchStoredProducts.Response(products: products)
        
        // When
        sut.presentStoredProducts(response: response)
        
        // Then
        let displayedProducts = productsListPresenterOutputSpy.viewModel.displayedProducts
        for displayedProduct in displayedProducts {
            XCTAssertEqual(displayedProduct.price, "$199.00", "Presenting fetched products should properly format price")
        }
    }
    
    func testPresentStoredProductsShouldAskViewControllerToDisplayFetchedProducts()
    {
        // Given
        let productsListPresenterOutputSpy = ProductsListPresenterOutputSpy()
        sut.output = productsListPresenterOutputSpy
        
        let products = [
            Product(
                id: "MLU441497969",
                site_id: "MLU",
                title: "Notebook Acer 14 Cloudbook 32gb Win10 Hasta 12 Pagos S/rec",
                price: NSDecimalNumber(string: "199"),
                currency_id: "USD",
                thumbnail: "http://mlu-s2-p.mlstatic.com/585221-MLU20740156773_052016-I.jpg",
                picture: "http://mlu-s2-p.mlstatic.com/585221-MLU20740156773_052016-O.jpg"
            )
        ]
        let response = ProductsList.FetchStoredProducts.Response(products: products)
        
        // When
        sut.presentStoredProducts(response: response)
        
        // Then
        XCTAssert(productsListPresenterOutputSpy.displayFetchedStoredOrdersCalled, "Presenting fetched products should ask view controller to display them")
    }
}