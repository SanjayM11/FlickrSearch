# SearchNFlickr

SearchNFlickr is an iOS App developed using Swift 4.2 on Xcode 10. 

This app lets you search and display Flickr Photos.

The application has following structure and source files -

- Comman (Group) includes -

    *Constants.swift* file, which contains constants used in app for Flickr API Key, error codes.
    
- ViewController (Group) includes -

    *SearchViewController.swift* file. This mainly has Search Bar to search images from Flickr, a Collection View to display searched images and related UI Stuff.
    
- Layouts (Group) includes - 

    *ThreeColumnFlowLayout.swift* file. This files mainy contains source to calculate the size, frame and layout of all the collection view items in three colums format.
    
- Cells (Group) includes - 

    *FlickrPhotoCell.swift* file. This file is inherited from UICollectioonViewCell, which mainly adds a UIImageView to display the Flickr images from cache(if it is available from cache) otherwise after downloading from asynchronous request.
    
- APIManager (Group) includes -

    *FlickrAPIManager.swift* file. The main purpose of this file is to execute data task on URLSession to fetch the list of Flickr photos.
   
- Model (Group) includes - 

     *FlickrPhoto.swift* file. Its a model class containing properties about Flickr photos.
     
- Utilities (Group) includes -

     *ImageCache.swift* file. Defines functionality to save image in cache and retrieve from the same.
     
- Storyboards -

     *Main.storyboard* file. Includes SearchViewController, having Search Bar and UICollection View added on the same.
     
     
**Future Scope-**
1) Improving UX & design.
2) Handling more error codes and edge cases.
3) Improvements in caching policy
4) UI and Unit test coverage.
5) Refactionring w.r.to latest API's.


     
     
     
    
 
    
    
    
    


