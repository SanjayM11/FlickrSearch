//
//  FlickrPhotoCell.swift
//  SearchNFlickr
//
//  Created by Sanjay Mohnani on 09/01/19.
//  Copyright © 2019 Sanjay Mohnani. All rights reserved.
//

import Foundation
import UIKit

class FlickrPhotoCell : UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    static let cellIdentifier = "FlickrPhotoCell"
    var photoUrl = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    var photo: FlickrPhoto? {
        didSet {
            if let photo = photo {
                if let cachedImage = ImageCache.shared.image(forKey: photo.photoUrl.absoluteString) {
                    self.imageView.image = cachedImage
                    return
                }
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: photo.photoUrl as URL){
                        DispatchQueue.main.async {
                            if let image = UIImage(data: data){
                                ImageCache.shared.save(image: image, forKey: photo.photoUrl.absoluteString)
                                if self.photoUrl == photo.photoUrl.absoluteString{
                                    self.imageView.image = image
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
