//
//  FlickrPhoto.swift
//  SearchNFlickr
//
//  Created by Sanjay Mohnani on 09/01/19.
//  Copyright © 2019 Sanjay Mohnani. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhoto {
    let photoId: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    init(withResponseDict dict: NSDictionary){
        if let photoId = dict["id"] as? String{
            self.photoId = photoId
        }else{
            self.photoId = ""
        }
        
        if let owner = dict["owner"] as? String{
            self.owner = owner
        }else{
            self.owner = ""
        }
        
        if let secret = dict["secret"] as? String{
            self.secret = secret
        }else{
            self.secret = ""
        }
        
        if let server = dict["server"] as? String{
            self.server = server
        }else{
            self.server = ""
        }
        
        if let farm = dict["farm"] as? Int{
            self.farm = farm
        }else{
            self.farm = 0
        }
        
        if let title = dict["title"] as? String{
            self.title = title
        }else{
            self.title = ""
        }
        
        if let ispublic = dict["ispublic"] as? Int{
            self.ispublic = ispublic
        }else{
            self.ispublic = 0
        }
        
        if let isfriend = dict["isfriend"] as? Int{
            self.isfriend = isfriend
        }else{
            self.isfriend = 0
        }
        
        if let isfamily = dict["isfamily"] as? Int{
            self.isfamily = isfamily
        }else{
            self.isfamily = 0
        }
    }
    
    var photoUrl: URL {
        return URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(photoId)_\(secret).jpg")!
    }
}

