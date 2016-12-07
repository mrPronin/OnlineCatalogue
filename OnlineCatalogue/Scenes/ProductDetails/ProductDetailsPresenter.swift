//
//  ProductDetailsPresenter.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright (c) 2016 Aleksandr Pronin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ProductDetailsPresenterInput
{
    func presentProduct(_ response: ProductDetails.GetProduct.Response)
}

protocol ProductDetailsPresenterOutput: class
{
    func displayProduct(_ viewModel: ProductDetails.GetProduct.ViewModel)
}

class ProductDetailsPresenter: ProductDetailsPresenterInput
{
    weak var output: ProductDetailsPresenterOutput!
    let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale(identifier: "en_US")
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()
    
    // MARK: - Presentation logic
    
    func presentProduct(_ response: ProductDetails.GetProduct.Response)
    {
        let product = response.product
        let price = currencyFormatter.string(from: product.price!)
        
        let dispayedProduct = ProductDetails.GetProduct.ViewModel.DisplayedProduct(id: product.id!, title: product.title!, price: price!, pictureURLString: product.picture!)
        
        let viewModel = ProductDetails.GetProduct.ViewModel(displayedProduct: dispayedProduct)
        output.displayProduct(viewModel)
    }
}