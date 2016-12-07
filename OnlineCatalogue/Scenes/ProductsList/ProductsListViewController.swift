//
//  ProductsListViewController.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright (c) 2016 Aleksandr Pronin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ProductsListViewControllerInput
{
    func displayFetchedStoredOrders(viewModel: ProductsList.FetchStoredProducts.ViewModel)
}

protocol ProductsListViewControllerOutput
{
    func fetchStoredProducts(request: ProductsList.FetchStoredProducts.Request)
}

class ProductsListViewController: UIViewController, ProductsListViewControllerInput
{
    var output: ProductsListViewControllerOutput!
    var router: ProductsListRouter!
    var displayedStoredProducts: [ProductsList.FetchStoredProducts.ViewModel.DispayedProduct] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "placeholder")!
        return image
    }()
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        ProductsListConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        fetchStoredProductsOnLoad()
        
    }
    
    // MARK: - Event handling
    
    func fetchStoredProductsOnLoad()
    {
        // NOTE: Ask the Interactor to do some work
        let request = ProductsList.FetchStoredProducts.Request()
        
        output.fetchStoredProducts(request: request)
    }
    
    // MARK: - Display logic
    
    func displayFetchedStoredOrders(viewModel: ProductsList.FetchStoredProducts.ViewModel)
    {
        displayedStoredProducts = viewModel.displayedProducts
        collectionView.reloadData()
    }
}

extension ProductsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedStoredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayedProduct = displayedStoredProducts[(indexPath as NSIndexPath).row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.ReuseIdentifier,
            for: indexPath
            ) as! ProductCollectionViewCell
        
        cell.configureCell(
            with: displayedProduct,
            placeholderImage: placeholderImage
        )
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension ProductsListViewController: UICollectionViewDelegate {
    
}
