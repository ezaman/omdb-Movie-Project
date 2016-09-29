//
//  MoviesCollectionViewController.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit


class MoviesCollectionViewController: UICollectionViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    
    
    var searchBar = UISearchBar(frame: CGRectZero)
    var image = UIImage()
    
    var movie: Movie?
    
    let store = MovieDataStore.sharedDataStore
    let apiClient = OMDBAPIClient()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsCancelButton = true

        self.navigationItem.titleView = searchBar
       
        self.tabBarController?.navigationItem.title = movie?.title
        
        
       
        self.store.searchMoviesWith("Comedy", page: self.apiClient.pageNum) { (success) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
        
                self.collectionView?.reloadData()
                
            })
        }
        
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let searchResult = searchBar.text
        guard let unwrappedSearch = searchResult else {return}
        
        if unwrappedSearch == ""
        {
            self.store.movieResults.removeAll()
            self.apiClient.pageNum = 1
            dispatch_async(dispatch_get_main_queue(),{
                self.store.searchMoviesWith("Comedy", page: self.apiClient.pageNum) { (success) in
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.collectionView?.reloadData()
                        
                    })
                }

                
            })
            
        }
        if unwrappedSearch != ""
        {
            self.store.movieResults.removeAll()
            
            let search = unwrappedSearch.stringByReplacingOccurrencesOfString(" ", withString: "+").lowercaseString
         
            self.apiClient.pageNum = 1
            
            self.store.searchMoviesWith(search, page: self.apiClient.pageNum, completionHandler: { (success) in
                //                print("page number inside \(self.apiClient.pageNum)")
                dispatch_async(dispatch_get_main_queue(),{
                    self.collectionView?.reloadData()
                })
            })
            
        }
        if store.movieResults.count == 0
        {
            dispatch_async(dispatch_get_main_queue(),{
                self.collectionView?.reloadData()
            })
        }
        
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.store.movieResults.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        //cell.movieName.text = self.store.movieResults[indexPath.row].title
        // NSOperationQueue().addOperationWithBlock {
       let backgroundView = UIView()
        
        backgroundView.backgroundColor = UIColor.whiteColor()
        cell.selectedBackgroundView = backgroundView
        
       cell.layer.borderWidth = 2.0
       cell.layer.borderColor = UIColor.whiteColor().CGColor
        
        if let unwrappedImage = self.store.movieResults[indexPath.row].poster {
            if unwrappedImage == "N/A" {
                cell.moviePoster.image = UIImage.init(named: "frown")
            }
            let imageURL = NSURL(string: unwrappedImage)
            
            if let url = imageURL {
                let imageData = NSData(contentsOfURL: url)
                
                if let unwrappedPoster = imageData {
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        cell.moviePoster.image = UIImage.init(data: unwrappedPoster)
                        
                        
                    })
                }
            }
     
        }
        
        
        return cell
    }
  
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let searchResult = searchBar.text
        guard let unwrappedSearch = searchResult else {return}
        
        if self.store.movieResults.count - 1 == indexPath.row {
            
            if unwrappedSearch == ""
            {
                self.apiClient.nextPage()
                self.store.searchMoviesWith("Comedy", page: apiClient.pageNum, completionHandler: { (success) in
                    dispatch_async(dispatch_get_main_queue(),{
                        self.collectionView?.reloadData()
                    })
                })
                
            }
            if unwrappedSearch != ""
            {
              
                self.apiClient.nextPage()
                
                //print("counts \(self.store.movieResults.count)")
                //print("page number outside \(self.apiClient.pageNum)")
                
                self.store.searchMoviesWith(unwrappedSearch, page: apiClient.pageNum,completionHandler: { (success) in
                    //                    print("page number inside \(self.apiClient.pageNum)")
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.collectionView?.reloadData()
                    })
                })
                
            }

        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
            
            let indexPath = collectionView!.indexPathForCell(sender as! UICollectionViewCell)
       
            if let unwrappedPath = indexPath {
                
                let movieID = self.store.movieResults[unwrappedPath.row]
                detailVC.movie = movieID
                
            }
        }
        
    }
    
}


