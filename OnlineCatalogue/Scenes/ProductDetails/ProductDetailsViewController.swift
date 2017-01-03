//
//  ProductDetailsViewController.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright (c) 2016 Aleksandr Pronin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import Alamofire
import AlamofireImage

protocol ProductDetailsViewControllerInput
{
    func displayProduct(_ viewModel: ProductDetails.GetProduct.ViewModel)
}

protocol ProductDetailsViewControllerOutput
{
    func getProduct(_ request: ProductDetails.GetProduct.Request)
    var product: Product! { get set }
    var storedProductOnly: Bool { get set }
}

class ProductDetailsViewController: UIViewController, ProductDetailsViewControllerInput
{
    var output: ProductDetailsViewControllerOutput!
    var router: ProductDetailsRouter!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "placeholder")!
        return image
    }()
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        ProductDetailsConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getProductOnLoad()
        
        /*
        if UIDevice.current.userInterfaceIdiom == .pad {
            navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        }
        */
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    // MARK: - Event handling
    
    func getProductOnLoad()
    {
        // NOTE: Ask the Interactor to do some work
        
        let request = ProductDetails.GetProduct.Request()
        output.getProduct(request)
    }
    
    // MARK: - Display logic
    
    func displayProduct(_ viewModel: ProductDetails.GetProduct.ViewModel)
    {
        let displayedProduct = viewModel.displayedProduct
        priceLabel.text = displayedProduct.price
        titleLabel.text = displayedProduct.title
        
        if let URLString = displayedProduct.pictureURLString {
            let size = thumbnailImageView.frame.size
            thumbnailImageView.af_setImage(
                withURL: URL(string: URLString)!,
                placeholderImage: placeholderImage,
                filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 20.0),
                imageTransition: .crossDissolve(0.2)
            )
        } else {
            thumbnailImageView.image = placeholderImage
        }
    }
}
