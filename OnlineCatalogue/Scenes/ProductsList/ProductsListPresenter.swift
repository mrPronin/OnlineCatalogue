//
//  ProductsListPresenter.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright (c) 2016 Aleksandr Pronin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ProductsListPresenterInput
{
    func presentStoredProducts(response: ProductsList.FetchStoredProducts.Response)
    func presentSearchResult(response: ProductsList.SearchProducts.Response)
}

protocol ProductsListPresenterOutput: class
{
    func displayFetchedStoredOrders(viewModel: ProductsList.FetchStoredProducts.ViewModel)
    func displaySearchResult(viewModel: ProductsList.SearchProducts.ViewModel)
}

class ProductsListPresenter: ProductsListPresenterInput
{
    weak var output: ProductsListPresenterOutput!
    let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale(identifier: "en_US")
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()
    
    // MARK: - Presentation logic
    
    func presentStoredProducts(response: ProductsList.FetchStoredProducts.Response)
    {
        var displayedProducts: [ProductsList.FetchStoredProducts.ViewModel.DispayedProduct] = []
        for product in response.products {
            let price = currencyFormatter.string(from: product.price!)
            let displayedProduct = ProductsList.FetchStoredProducts.ViewModel.DispayedProduct(id: product.id, site_id: product.site_id!, title: product.title!, price: price!, currency_id: product.currency_id!, thumbnailURLString: product.thumbnail!)
            displayedProducts.append(displayedProduct)
        }
        let viewModel = ProductsList.FetchStoredProducts.ViewModel(displayedProducts: displayedProducts)
        output.displayFetchedStoredOrders(viewModel: viewModel)
    }
    
    func presentSearchResult(response: ProductsList.SearchProducts.Response)
    {
        var displayedProducts: [ProductsList.SearchProducts.ViewModel.DispayedProduct] = []
        for product in response.products {
            let price = currencyFormatter.string(from: product.price!)
            let displayedProduct = ProductsList.SearchProducts.ViewModel.DispayedProduct(id: product.id, title: product.title!, price: price!, thumbnailURLString: product.thumbnail!)
            displayedProducts.append(displayedProduct)
        }
        let viewModel = ProductsList.SearchProducts.ViewModel(displayedProducts: displayedProducts)
        output.displaySearchResult(viewModel: viewModel)
    }
}
