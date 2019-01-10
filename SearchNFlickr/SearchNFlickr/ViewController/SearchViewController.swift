//
//  SearchViewController.swift
//  SearchNFlickr
//
//  Created by Sanjay Mohnani on 09/01/19.
//  Copyright © 2019 Sanjay Mohnani. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var photos: [FlickrPhoto] = []
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchWithText(searchText: searchBar.text!)
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrPhotoCell.cellIdentifier, for: indexPath)
        cell.tag = indexPath.row
        if let cell = cell as? FlickrPhotoCell {
            cell.imageView.image = nil
            let photoData = photos[indexPath.item]
            cell.photoUrl = photoData.photoUrl.absoluteString
            cell.photo = photoData
        }
        return cell
    }
    
    // MARK: - Private
    private func searchWithText(searchText: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        FlickrAPIManager.fetchFlickrPhotosForSearchedText(searchedText: searchText, onCompletion: { (flickrPhotos: [FlickrPhoto]?, error: NSError?) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            if error == nil {
                self.photos = flickrPhotos!
            } else {
                self.photos = []
                if error!.code == Errors.invalidAPIKey {
                    self.showAlertWithMessage("Invalid API Key!")
                }else if error!.code == Errors.internetOffline{
                    self.showAlertWithMessage("The Internet connection appears to be offline!")
                }
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.title = searchText
                self.collectionView.reloadData()
            })
        })
    }
    
    // MARK: - helper methods
    private func showAlertWithMessage(_ message: String) {
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    // MARK: - Actions
    @IBAction func resetSearch(sender: AnyObject) {
        photos.removeAll()
        searchBar.text = ""
        searchBar.resignFirstResponder()
        collectionView.reloadData()
        self.title = "Flickr Search"
    }
}
