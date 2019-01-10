//
//  FlickrAPIManager.swift
//  SearchNFlickr
//
//  Created by Sanjay Mohnani on 09/01/19.
//  Copyright © 2019 Sanjay Mohnani. All rights reserved.
//

import Foundation

class FlickrAPIManager {
    
    typealias FlickrAPIResponse = ([FlickrPhoto]?, NSError?) -> Void
    
    class func fetchFlickrPhotosForSearchedText(searchedText : String, onCompletion: @escaping FlickrAPIResponse) -> Void{
        let escapedText: String = searchedText.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrAPIKey)&format=json&nojsoncallback=1&safe_search=1&text=\(escapedText)"
        let url: NSURL = NSURL(string: urlString)!
        let dataTask = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error -> Void in
            if error != nil {
                print("Error in fetching photos: \(error.debugDescription)")
                onCompletion(nil, error as NSError?)
                return
            }
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results["code"] as? Int {
                    if statusCode == Errors.invalidAPIKey {
                        let invalidAPIKeyError = NSError(domain: "com.flickr.api", code: statusCode, userInfo: nil)
                        onCompletion(nil, invalidAPIKeyError)
                        return
                    }
                }
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                let flickrPhotos: [FlickrPhoto] = photosArray.map { photoDictionary in
                    let flickrPhoto =  FlickrPhoto.init(withResponseDict: photoDictionary)
                    return flickrPhoto
                }
                onCompletion(flickrPhotos, nil)
                
            } catch let error as NSError {
                print("Error in parsing JSON - \(error)")
                onCompletion(nil, error)
                return
            }
        })
        dataTask.resume()
    }
}
