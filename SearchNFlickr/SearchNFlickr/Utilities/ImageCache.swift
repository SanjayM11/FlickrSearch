//
//  ImageCache.swift
//  SearchNFlickr
//
//  Created by Sanjay Mohnani on 09/01/19.
//  Copyright © 2019 Sanjay Mohnani. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!
    
    static let shared = ImageCache()
    
    private init() {
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification , object: nil, queue: nil, using: { [weak self] notification in
            self?.cache.removeAllObjects()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
