//
//  ProductCollectionViewCell.swift
//  OnlineCatalogue
//
//  Created by Aleksandr Pronin on 12/6/16.
//  Copyright © 2016 Aleksandr Pronin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
//    class var ReuseIdentifier: String { return "\(type(of: self))" }
    class var ReuseIdentifier: String { return "ProductCollectionViewCell" }
    
    // MARK: - Lifecycle Methods
    
    func configureCell(with displayedProduct: ProductsList.FetchStoredProducts.ViewModel.DispayedProduct, placeholderImage: UIImage) {
        let size = thumbnailImageView.frame.size
        let URLString = displayedProduct.thumbnailURLString
        priceLabel.text = displayedProduct.price
        thumbnailImageView.af_setImage(
            withURL: URL(string: URLString)!,
            placeholderImage: placeholderImage,
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 20.0),
            imageTransition: .crossDissolve(0.2)
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.af_cancelImageRequest()
        thumbnailImageView.layer.removeAllAnimations()
        thumbnailImageView.image = nil
    }
}
